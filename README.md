To setup on new machine
```bash
# Install Lix
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
# Setup config folder
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
git clone git@github.com:hbhungg/config.git /etc/nix-darwin
cd /etc/nix-darwin
# Install nix-darwin
sudo nix run nix-darwin/master#darwin-rebuild -- switch
```

Apply configuration
```bash
sudo darwin-rebuild switch
# Or
switch # Alias to above
```
