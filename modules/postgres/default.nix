{
  config,
  pkgs,
  ...
}: {
  services.postgresql = {
    enable = true;

    ensureDatabases = ["coffee"];
    ensureUsers = [
      {
        name = "wilko";
      }
    ];

    authentication = pkgs.lib.mkForce ''
      # Local socket connections (for administration)
      local   all             all                                     peer
      # TCP/IP connections (for DBAnalyzer)
      host    all             all             127.0.0.1/32            scram-sha-256
      host    all             all             ::1/128                 scram-sha-256
    '';

    # package = pkgs.postgresql_15;
  };
}
