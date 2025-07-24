# nix setup – quick reference

## daily rebuild
```bash
sudo nixos-rebuild switch --flake .#koinu
```

## update packages (pull newer nixpkgs / home-manager)
```bash
nix flake update        # refresh inputs
sudo nixos-rebuild switch --flake .#koinu
```

## development shell
```bash
nix develop             # git, eza, bat, rg, nix fmt …
```

## first login shell change
```bash
sudo chsh -s /run/current-system/sw/bin/zsh fawn
```