{ config, pkgs, lib, ... }: {
  home.username = "junwoolee";
  
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/junwoolee" else "/home/junwoolee";

  home.stateVersion = "25.11";

  home.backupFileExtension = "bak";

  programs.git = {
    enable = true;
    userName = "Junwoo Lee";
    userEmail = "lee.junwoo@berkeley.edu";
  };
}
