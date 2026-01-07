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
      environment.systemPackages = with pkgs; [ 
        coreutils
        bashInteractive
        vim
        neovim
        uv
        ripgrep
        bat
        tmux-mem-cpu-load
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

      environment.systemPath = [
        "/run/current-system/sw/bin"
        "/etc/profiles/per-user/wren/bin"
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

      # --- Dock Management (System Level) ---
      system.defaults.dock = {
        autohide = true;
        show-recents = false;
        persistent-apps = [
          "/Users/wren/Applications/Home Manager Apps/Alacritty.app"
          "/Applications/Zen.app"
          "/System/Applications/System Settings.app"
        ];
      };

      # --- Home Manager Configuration ---
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        verbose = true;
        extraSpecialArgs = { inherit inputs; };
        users.wren = { pkgs, ... }: {
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
            shellAliases = {
              switch = "sudo darwin-rebuild switch --flake .#nest-2";
              grep = "rg --color=auto";
              ls = "ls --color=auto";
              ll = "ls -alF";
              vi = "nvim";
              cat = "bat --theme='Visual Studio Dark+' --paging=never";
              wgit = "watch -n 0.5 --color git -c color.status=always status";
              uuidgen = "uuidgen | tr A-F a-f";
            };
            initExtra = ''
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
            extraConfig = "TAB: menu-complete";
          };

          programs.fzf = {
            enable = true;
            enableBashIntegration = true;
          };

          programs.alacritty = {
            enable = true;
            settings = {
              window = { dynamic_padding = true; };
              env = { TERM = "xterm-256color"; };
              font = {
                size = 12.0;
                offset = { x = 0; y = 3; };
                normal = { family = "SF Mono"; style = "Regular"; };
                bold = { family = "SF Mono"; style = "Bold"; };
              };
              colors = {
                primary = { background = "#1E1E1E"; foreground = "#FFFFFF"; };
                normal = {
                  black = "#666666"; red = "#D64A2E"; green = "#40C731"; yellow = "#999900";
                  blue = "#007ACC"; magenta = "#E44CE1"; cyan = "#40C5D1"; white = "#FFFFFF";
                };
                bright = {
                  black = "#888888"; red = "#D64A2E"; green = "#40C731"; yellow = "#999900";
                  blue = "#007ACC"; magenta = "#E44CE1"; cyan = "#40C5D1"; white = "#FFFFFF";
                };
              };
            };
          };

          programs.htop = {
            enable = true;
            settings.show_program_path = true;
          };

          programs.tmux = {
            enable = true;
            terminal = "xterm-256color";
            prefix = "`";
            keyMode = "vi";
	    extraConfig = ''
              set -g default-command "/run/current-system/sw/bin/bash"
              set -ag terminal-overrides ",xterm-256color:RGB"
              bind-key ` last-window
              bind-key e send-prefix
              bind-key b select-window -t:-1
              bind c new-window -c "#{pane_current_path}"
              bind-key = split-window -h -c "#{pane_current_path}"
              bind-key - split-window -v -c "#{pane_current_path}"
              set -g set-titles on
              set -g status-interval 1
              set -g focus-events on
              set -g status-justify left
              set -g status-position bottom
              set-window-option -g window-status-separator '  '
              set-option -g status-style fg=color137,bg=default
              set -g status-left ' '
              set -g status-right '#H:#S #[fg=colour255,bg=default] #(tmux-mem-cpu-load --interval 1 -a 0 -g 0)  %I:%M %p '
              set -g status-right-length 140
              set -g status-left-length 20
              setw -g window-status-current-format '#I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F'
              setw -g window-status-format '#[fg=colour240]#I:#W#[fg=colour255]#F'
              set-option -g automatic-rename on

              is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
              bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
              bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
              bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
              bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

              tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
              if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
                  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
              if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
                  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

              bind-key -T copy-mode-vi 'C-h' select-pane -L
              bind-key -T copy-mode-vi 'C-j' select-pane -D
              bind-key -T copy-mode-vi 'C-k' select-pane -U
              bind-key -T copy-mode-vi 'C-l' select-pane -R
              bind-key -T copy-mode-vi 'C-\' select-pane -l
            '';
            plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator ];
          };

          home.sessionVariables = { 
            EDITOR = "nvim"; 
            VISUAL = "nvim";
            LSCOLORS = "GxBxhxDxfxhxhxhxhxcxcx";
	    LS_COLORS = "di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
            TERM = "xterm-256color";
          };

          home.file = {
            ".vimrc".source = ./vimrc;
            ".editrc".source = ./editrc;
          };

          programs.git.enable = true;
	  programs.delta = {
	    enable = true;
	    enableGitIntegration = true;
	    options = {
              features = "side-by-side";
              syntax-theme = "ansi";
              paging = "always";
              pager = "less";
              file-style = "red bold ul";
              file-decoration-style = "blue box"; 
            };
	  };
          programs.git.settings = {
            user.name = "hbhungg";
            user.email = "hung.ba.huynh@proton.me";
            alias = {
              st = "status";
              lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
              p = "push";
              cn = "commit";
              c = "commit";
	      d = "diff";
            };
            core = {
              editor = "nvim";
              compression = 9;
              preloadindex = true;
              ignorecase = false;
            };
            init.defaultBranch = "main";
            column.ui = "auto";
            status = { branch = true; showStash = true; showUntrackedFiles = "all"; };
            commit.verbose = true;
            push = { default = "simple"; autoSetupRemote = true; };
            diff = { algorithm = "histogram"; colorMoved = "plain"; mnemonicPrefix = true; renames = true; };
            branch.sort = "-committerdate";
            tag.sort = "version:refname";
          };
        };
      };

      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."nest-2" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
