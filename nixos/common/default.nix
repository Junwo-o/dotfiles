{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
