{ config, pkgs, ... }:

# NOTICE: We no longer need the custom network variable!
{
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {

        searxng = {
          image = "searxng/searxng:latest";
          autoStart = true;
          ports = [ "127.0.0.1:8888:8080" ]; 
          volumes = [
            "/var/lib/searxng/settings.yml:/etc/searxng/settings.yml:ro"
            "/var/lib/searxng/cache:/var/cache/searxng"
          ];
          environment = {
            SEARXNG_BASE_URL = "http://localhost:8888";
            INSTANCE_NAME = "NixOS SearXNG";
          };
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8080 ]; 

  systemd.tmpfiles.rules = [
    "d /var/lib/searxng 0755 root root -"
    "d /var/lib/searxng/cache 0755 root root -"
  ];

  system.activationScripts.searxng-settings = ''
    mkdir -p /var/lib/searxng/cache

    if [ ! -f /var/lib/searxng/secret_key ]; then
      echo "Generating SearXNG secret key..."
      head -c 32 /dev/urandom | base64 > /var/lib/searxng/secret_key
      chmod 600 /var/lib/searxng/secret_key
    fi

    SECRET_KEY=$(cat /var/lib/searxng/secret_key)

    cat > /var/lib/searxng/settings.yml << EOF
    use_default_settings: true

    general:
      instance_name: "NixOS SearXNG"

    search:
      safe_search: 0
      autocomplete: ""
      default_lang: "en-US"
      formats:
        - html
        - json
      error_handler: true

    server:
      port: 8080
      bind_address: "0.0.0.0"
      secret_key: "$SECRET_KEY"
      limiter: false
      public_instance: false

    engines:
      - name: duckduckgo
        engine: duckduckgo
        shortcut: ddg
        disabled: false
      - name: brave
        engine: brave
        shortcut: br
        disabled: false
      - name: wikipedia
        engine: wikipedia
        shortcut: wp
        disabled: false
      - name: github
        engine: github
        shortcut: gh
        disabled: false
      - name: google
        engine: google
        shortcut: g
        disabled: false
    EOF

    chmod 644 /var/lib/searxng/settings.yml
  '';

  systemd.services.init-searxng-network = {
    description = "Create the Docker network for SearXNG";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.docker}/bin/docker network inspect searxng-net >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create searxng-net
    '';
  };
}