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
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = [ "--stdio" ];
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
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
