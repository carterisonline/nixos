pkgs:

{
  enable = true;
  functions = {
    __fish_command_not_found_handler = {
      body = ", $argv";
      onEvent = "fish_command_not_found";
    };
  };
  loginShellInit = ''
    direnv hook fish | source
  
    set hydro_symbol_prompt ">"
    set base16_fish_shell_background "dark"

    bind "^\\x7F" backward-kill-word
    bind "^\\e\\[3~" kill-word
  '';
  plugins = [
    {
      name = "base16";
      src = pkgs.fetchFromGitHub {
        owner = "FabioAntunes";
        repo = "base16-fish-shell";
        rev = "d316303311da0f371cea07721830ccd1bb512e9c";
        sha256 = "1kn637jl6lrrvwdd28hlrvyhw42vcx7wnnkcgvs12xpwnal81sd4";
      };
    }
    {
      name = "hydro";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "hydro";
        rev = "bc31a5ebc687afbfb13f599c9d1cc105040437e1";
        sha256 = "0c4c0w597si3pr07mldwvgwjdf0nzrv0s35h4i7kcvji8crj5hyh";
      };
    }
  ];
  shellAliases = {
    gc = "git add . && git commit -m";
    sgc = "sudo git add . && sudo git commit -m";
  };
}
