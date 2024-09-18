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
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      "nil" = {
        "formatting" = {
          "command" = [
            "nixfmt"
          ];
        };
      };
    };
    "rust-analyzer.completion.termSearch.enable" = true;
    "rust-analyzer.imports.granularity.group" = "module";
    "rust-analyzer.imports.prefix" = "crate";
    "rust-analyzer.semanticHighlighting.operator.specialization.enable" = true;
    "rust-analyzer.semanticHighlighting.punctuation.enable" = true;
    "rust-analyzer.semanticHighlighting.punctuation.separate.macro.bang" = true;
    "rust-analyzer.semanticHighlighting.punctuation.specialization.enable" = true;
    "window.titleBarStyle" = "custom";
    "workbench.iconTheme" = "material-icon-theme";
    "zig.initialSetupDone" = true;
    "zig.path" = "zig";
    "zig.zls.path" = "zls";
  };
}
