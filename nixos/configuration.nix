{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.hostName = "carbon";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  virtualisation.docker.enable = true;

  programs.light.enable = true;

  sound.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };  

  users.users = {
    chris = {
      initialPassword = "1234";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
    };
  };

  security.polkit.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
