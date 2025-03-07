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
    {
      key = "numpad_add";
      command = "editor.action.revealDefinition";
      when = "editorHasDefinitionProvider && editorTextFocus";
    }
    {
      key = "ctrl+e s";
      command = "editor.action.deleteLines";
      when = "textInputFocus && !editorReadonly";
    }
    {
      key = "ctrl+e a";
      command = "deleteAllLeft";
    }
    {
      key = "ctrl+e d";
      command = "deleteAllRight";
    }
    {
      key = "ctrl+e w";
      command = "deleteInsideWord";
    }
  ];

  userSettings = {
    "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
    "editor.formatOnSave" = true;
    "editor.inlayHints.enabled" = "offUnlessPressed";
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
    "remote.SSH.useLocalServer" = false;
    "remote.SSH.remotePlatform" = {
      "10.20.108.10" = "linux";
    };
    "rust-analyzer.completion.termSearch.enable" = true;
    "rust-analyzer.imports.granularity.group" = "module";
    "rust-analyzer.imports.prefix" = "crate";
    "rust-analyzer.inlayHints.chainingHints.enable" = false;
    "rust-analyzer.inlayHints.expressionAdjustmentHints.enable" = "always";
    "rust-analyzer.inlayHints.expressionAdjustmentHints.hideOutsideUnsafe" = true;
    "rust-analyzer.interpret.tests" = true;
    "rust-analyzer.semanticHighlighting.operator.specialization.enable" = true;
    "rust-analyzer.semanticHighlighting.punctuation.enable" = true;
    "rust-analyzer.semanticHighlighting.punctuation.separate.macro.bang" = true;
    "rust-analyzer.semanticHighlighting.punctuation.specialization.enable" = true;
    "window.titleBarStyle" = "custom";
    "workbench.iconTheme" = "material-icon-theme";
    "zig.path" = "zig";
    "zig.zls.path" = "zls";
  };
}
