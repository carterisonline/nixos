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
    "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
    "editor.formatOnSave" = true;
    "editor.minimap.enabled" = false;
    "[nix]"."editor.tabSize" = 2;
    "window.titleBarStyle" = "custom";
    "workbench.iconTheme" = "material-icon-theme";
    "zig.initialSetupDone" = true;
    "zig.path" = "zig";
    "zig.zls.path" = "zls";
  };
}
