{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
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
      modules = [ configuration ];
    };
  };
}
