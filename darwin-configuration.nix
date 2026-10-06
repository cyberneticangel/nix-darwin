{ pkgs, ... }:

{
  # Let nix-darwin manage nix itself
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Required: matches the darwin-rebuild version you're bootstrapping with
  system.stateVersion = 5;

  # Set your primary user (required in recent nix-darwin versions
  # for user-scoped options like homebrew, defaults, etc.)
  system.primaryUser = "dylan";

  # Hostname / networking basics
  networking.hostName = "travesty";

  # Minimal system-wide packages (keep this small —
  # your Zig/Rust/Go toolchains live in per-project dev shells)
  environment.systemPackages = [
    pkgs.git
    pkgs.curl
  ];

  # Use the same nixpkgs version as your system Nix
  nixpkgs.hostPlatform = "aarch64-darwin"; # or "x86_64-darwin"

  # Allow non-free packages if you ever need them (e.g. some LLDB/debugger bits)
  nixpkgs.config.allowUnfree = true;
}
