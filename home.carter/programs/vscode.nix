pkgs:

{
  enable = true;
  enableUpdateCheck = false;

  extensions = with pkgs.vscode-extensions; [
    ibm.output-colorizer
    jnoortheen.nix-ide
    nvarner.typst-lsp
    pkief.material-icon-theme
    rust-lang.rust-analyzer
    samuelcolvin.jinjahtml
    tamasfe.even-better-toml
    ziglang.vscode-zig
    usernamehw.errorlens
  ];
  
  keybindings = [
    {
      key = "alt+a";
      command = "editor.action.quickFix";
    }
  ];

  userSettings = {
    "editor.formatOnSave" = true;
    "[nix]"."editor.tabSize" = 2;
    "zig.path" = "zig";
    "zig.zls.path" = "zls";
    "workbench.iconTheme" = "material-icon-theme";
    "editor.minimap.enabled" = false;
  };
}
