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
      environment.pathsToLink = [ "/share/bash-completion" ];
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
        verbose = true;
        extraSpecialArgs = { inherit inputs; };
      };
      home-manager.users.wren = { pkgs, ... }: {
        home.stateVersion = "25.11";

        programs.home-manager.enable = true;
        programs.bash = { 
          enable = true;
          enableCompletion = true;
          enableVteIntegration = true;
          historyControl = [ "ignoreboth" "erasedups" ];
          historySize = 1000;
          historyFileSize = 2000;
          historyIgnore = [ "ls" "exit" ];
          initExtra = ''
            # Enable histappend and checkwinsize
            shopt -s histappend
            shopt -s checkwinsize
            if [ -f "${pkgs.git}/share/git/contrib/completion/git-prompt.sh" ]; then
              GIT_PROMPT_ONLY_IN_REPO=1
              source "${pkgs.git}/share/git/contrib/completion/git-prompt.sh"
            fi
            get_exit_status(){
             es=$?
             if [ $es -eq 0 ]; then echo -e ""
             else echo -e "''${es} "
             fi
            }
            export PS1='\[\e[01;38m\]\u@\h\[\e[00m\] \[\e[01;32m\]\w\[\e[00m\]\[\e[00;35m\]$(__git_ps1)\[\e[00m\] \[\e[01;31m\]» $(get_exit_status)\[\e[00m\]'
            export PS2='» '
          '';
        };
        programs.readline = {
          enable = true;
          variables = {
            editing-mode = "vi";
            keyseq-timeout = 10;
            show-all-if-ambiguous = "on";
          };
          extraConfig = ''
            TAB: menu-complete
          '';
        };
        programs.fzf = {
          enable = true;
          enableBashIntegration = true;
        };
        programs.htop.enable = true;
        programs.vscode = { enable = true; };
        programs.htop.settings.show_program_path = true;
        home.sessionVariables = { 
          EDITOR = "nvim"; 
          VISUAL = "nvim";
          LC_ALL = "en_US.UTF-8";
          LANG = "en_US.UTF-8";
          LANGUAGE = "en_US.UTF-8";
          LSCOLORS = "GxBxhxDxfxhxhxhxhxcxcx";
          LS_COLORS = "GxBxhxDxfxhxhxhxhxcxcx";
          TERM = "xterm-256color";
        };

        home.packages = [ ];

        home.file = {
          ".vimrc".source = ./vimrc;
          ".editrc".source = ./editrc;
        };

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
