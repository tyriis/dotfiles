{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.go-task
    pkgs.chezmoi
    pkgs.vault
    pkgs.age
    pkgs.sops
    pkgs.nodePackages.zx
  ];

  EDITOR = "code -r -w";
  GITHUB_USERNAME = "tyriis";
}
