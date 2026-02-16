{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.lsp.display-messages = true;
    };
    languages = {
      language-server = {
        typescript-language-server = with pkgs.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          formatting.command = [ "alejandra" ];
          # I use helix for random files, so we rely on system-wide nixpkgs rather than assuming there's a flake in pwd
          nixpkgs.expr = ''import (builtins.getFlake "/etc/nixos").inputs.nixpkgs { }'';
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "${pkgs.biome}/bin/biome";
            args = [ "format" "--stdin-file-path=file.ts" ];
          };
        }
      ];
    };
  };
}
