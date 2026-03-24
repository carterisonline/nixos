{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        completion-replace = true;
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "disable";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
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
        {
          name = "glsl";
          file-types = ["glsl" "fsh" "vsh" "vert" "frag"];
        }
      ];
    };
  };
}
