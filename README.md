# Dotfiles

This is an early draft of my effort to standardize my packages configurations with the help of Nix and Home Manager. The overall goal being a "local dev as code" approach.

This repo is being kept public in order to share my setup if needed and to mentally force myself to avoid storing any secrets in these files.

> Note: This is a WIP. I will be most likely building these configurations one at a time to avoid breaking my current setup that is crucial for work.

### Packages
- [ ] git
- [x] gh
- [ ] zsh
- [x] starship
- [ ] neovim
- [x] jq
- [x] yq
- [x] eza
- [x] ripgrep
- [x] bat
- [x] fzf
- [x] fnm
- [x] tokei
- [ ] aws-cli 
- [ ] google-cloud-sdk
- [ ] kubectl
- [ ] helm
- [ ] terraform

### Update

```
home-manager switch --flake .
```
