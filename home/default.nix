{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.go-task
    pkgs.chezmoi
    pkgs.htop
    pkgs.direnv
  ];

  EDITOR = "code -r -w";
  GITHUB_USERNAME = "tyriis";
}
