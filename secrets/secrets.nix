let
  main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOz/K8j6LQJxhQ6tnpJHIvmtuS2A2XPBePjYlmy9412h root@nixos";
  systems = [main];
in {
  "steam-api-key.age".publicKeys = systems;
}
