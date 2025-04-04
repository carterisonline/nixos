pkgs:

{
  enable = true;
  functions = {
    __fish_command_not_found_handler = {
      body = ''
        function __cnf_cleanup_exit
          set --erase __cnf_resolved || true
          set --erase __cnf_resolved_pkg || true
          set --erase __cnf_selected || true
          set --erase __cnf_trimmed || true
          set --erase __cnf_args || true

          return $argv[1]
        end

        function __cnf_run
          if test (echo $argv[3] | string length) -gt 0
            set __cnf_args (echo $argv[3] | string split " ")
            nix shell "nixpkgs#$argv[1]" -c $argv[2] $__cnf_args
            __cnf_cleanup_exit $status
            return $status
          else
            nix shell "nixpkgs#$argv[1]" -c $argv[2]
            __cnf_cleanup_exit $status
            return $status
          end
        end
                
        set __cnf_resolved (rg "^$argv[1]:" ~/.cache/cnf-resolved 2>/dev/null)
        if test $status -eq 0
          set __cnf_resolved_pkg (echo $__cnf_resolved | sd '^.*:(\w+)$' '$1')
          __cnf_run $__cnf_resolved_pkg $argv[1] "$argv[2..-1]"
          return $status
        else if nix derivation show "nixpkgs#$argv[1]" >/dev/null 2>/dev/null
          echo "$argv[1]:$argv[1]" >> ~/.cache/cnf-resolved
          __cnf_run $argv[1] $argv[1] "$argv[2..-1]"
          return $status
        else
          function trim_out
            echo $argv[1] | sd '\.(out|bin)' ""
          end
          
          set __cnf_resolved (nix-locate -w --top-level --at-root --minimal "/bin/$argv[1]" 2>/dev/null)
          if test $status -eq 0
            if test (count $__cnf_resolved) -eq 1
              set __cnf_trimmed (trim_out $__cnf_resolved[1])
            else
              set __cnf_selected (echo __cnf_resolved | fzf)
              set __cnf_trimmed (trim_out $__cnf_selected)
            end
            echo "$argv[1]:$__cnf_trimmed" >> ~/.cache/cnf-resolved
            __cnf_run $__cnf_trimmed $argv[1] "$argv[2..-1]"
            return $status
          else
            echo "$argv[1]: command not found" >&2
            __cnf_cleanup_exit 127
            return $status
          end
        end
      '';
      onEvent = "fish_command_not_found";
    };
    __fzf_last = ''
      set -l FZF_OUT (eval $history[1] | fzf --height 40%)
      if test -n "$FZF_OUT"
        commandline -r $FZF_OUT
        commandline --cursor 0
      end
    '';
  };
  loginShellInit = ''
    direnv hook fish | source
  
    set hydro_symbol_prompt ">"
    set base16_fish_shell_background "dark"

    bind "^\\x7F" backward-kill-word
    bind "^\\e\\[3~" kill-word
    bind \er __fzf_last
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
    {
      name = "fzf.fish";
      src = pkgs.fishPlugins.fzf;
    }
  ];
  shellAliases = {
    gc = "git add . && git commit -m";
    sgc = "sudo git add . && sudo git commit -m";
    rt-gl-intel = "nixGLIntel nix-alien -f";
    rt-vk-intel = "nixVulkanIntel nix-alien -f";
    nixos-rebuild-nonfree = "sudo bash -c 'export NIXPKGS_ALLOW_UNFREE=1 && nixos-rebuild switch --impure -L'";
  };
}
