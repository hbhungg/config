{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      programs.bash.enable = true;
      environment.shells = [ pkgs.bash ];
      system.primaryUser = "wren";
      users.users.wren = {
        name = "wren";
        home = "/Users/wren";
        shell = pkgs.bash;
      };

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ 
        vim
        neovim
        tmux
        uv
        alacritty
        orbstack
        k9s
        rectangle
        bitwarden-desktop
        bitwarden-cli
        obsidian
        discord
        slack
        spotify
      ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
        taps = [];
        brews = [];
        casks = [
          "linearmouse"
          "zen"
        ];
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
	backupFileExtension = "backup";
	extraSpecialArgs = { inherit inputs; };
      };
      home-manager.users.wren = { pkgs, ... }: {
	home.stateVersion = "25.11";

	programs.bash.enable = true;
	programs.htop.enable = true;
	programs.htop.settings.show_program_path = true;

	home.packages = [ ];

	programs.git.enable = true;
	programs.git.settings = {
          user.name = "hbhungg";
          user.email = "hung.ba.huynh@proton.me";
	  alias = {
            st = "status";
            lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
            p = "push";
            cn = "commit";
            c = "commit";
          };

          core = {
	    editor = "nvim";
            compression = 9;
            preloadindex = true;
            ignorecase = false;
	  };
	  init.defaultBranch = "main";
	  column.ui = "auto";
	  status = {
            branch = true;
            showStash = true;
            showUntrackedFiles = "all";
          };
	  commit.verbose = true;
	  push = {
            default = "simple";
            autoSetupRemote = true;
          };
	  diff = {
            algorithm = "histogram";
            colorMoved = "plain";
            mnemonicPrefix = true;
            renames = true;
          };
	  branch.sort = "-committerdate";
          tag.sort = "version:refname";
	  filter."lfs" = {
            smudge = "git-lfs smudge -- %f";
            process = "git-lfs filter-process";
            required = true;
            clean = "git-lfs clean -- %f";
          };
        };
      };

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app/"
          "/Applications/Zen.app/"
          "/System/Applications/System Settings.app"
        ];
      };


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#nest-2
    darwinConfigurations."nest-2" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
