let

  pkgs = import ./nix/pkgs {};
  deps = import ./nix/deps {};
  ops  = import ./nix/ops {};

in

  deps // pkgs // ops
