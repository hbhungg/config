# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). The source directory is this repo
(`~/config`), set via `sourceDir` in `~/.config/chezmoi/chezmoi.toml`.

### Setup on a new machine
```bash
brew install chezmoi
git clone https://github.com/hbhungg/config ~/config
mkdir -p ~/.config/chezmoi
echo 'sourceDir = "~/config"' > ~/.config/chezmoi/chezmoi.toml
chezmoi apply
```

### Daily use
```bash
chezmoi edit ~/.bashrc   # edit the source, then applies on save
chezmoi diff             # see drift between repo and live files
chezmoi apply            # push repo state to live files
chezmoi re-add           # pull live edits (e.g. from Karabiner GUI) back into the repo
```

Note: unlike stow, files are **copies**, not symlinks. If you edit a live file
directly (or an app rewrites its own config), run `chezmoi re-add` to sync it back.

### For rectangle and stats
The configuration files are in `extra/`. Manually import them through the UI.
