{ config, pkgs, ... }:
{

  # Configure daily duplicity backup. Destination hidden for security reasons
  services.duplicity = {
    enable = true;
    secretFile = "/etc/duplicity.d/credentials";
    include = ["/home/ashton/"];
    exclude = ["/**" "/home/ashton/.*/**" "/home/ashton/Downloads"];
  };
}
