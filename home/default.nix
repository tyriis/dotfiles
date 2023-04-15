{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.go-task
    pkgs.chezmoi
    pkgs.vault
    pkgs.age
    pkgs.sops
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.spaceship-prompt
    pkgs.nodePackages.zx
  ];

  EDITOR = "code -r -w";
  GITHUB_USERNAME = "tyriis";
}
