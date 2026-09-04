{...}: {
  # configuration.nix
  services.gnome.gnome-keyring.enable = true;

  # Ensure PAM creates the login keyring on login
  security.pam.services.login.enableGnomeKeyring = true;
}
