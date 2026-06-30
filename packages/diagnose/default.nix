{
  gnused,
  unixtools,
  writeShellScriptBin,
}:
writeShellScriptBin "diagnose" ''
  esc=$(printf "\033")

  printf 'uptime~Simple load averages
  sudo dmesg | tail~Brief system messages
  vmstat 1~CPU saturation, time in kernel/io/user, swap stats
  pidstat 1~Brief process stats
  iostat -xz 1~Per-device IO stats, preemption time
  free -m~Memory usage inc. buffer and cache sizes
  sar -n DEV 1~Network throughput
  sar -n TCP,ETCP 1~Kernel-space TCP throughput
  top~Catch-all' | ${gnused}/bin/sed -E "s/^[^~]+/$esc[1;36m\0$esc[0m/" | ${unixtools.column}/bin/column -t -s~
''
