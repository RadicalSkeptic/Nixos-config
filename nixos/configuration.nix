# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      dejavu_fonts
      lohit-fonts.bengali
      liberation_ttf
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.jetbrains-mono
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sifat = {
    isNormalUser = true;
    description = "sifat";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Git
  programs.git.enable = true;

  # Install firefox.
  #programs.firefox.enable = true;

  # Chromium
  programs.chromium = {
    enable = true;
    homepageLocation = "https://www.startpage.com/";
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # dark reader
      "blcdfhbibkkjpfdddnmnmhfgjlicebba;https://clients2.google.com/service/update2/crx" # limit
      "gebbhagfogifgggkldgodflihgfeippi;https://clients2.google.com/service/update2/crx" # return youtube dislike
      "dbepggeogbaibhgnhhndojpepiihcmeb;https://clients2.google.com/service/update2/crx" # vimium
      "ghmbeldphafepmbegfdlkpapadhbakde;https://clients2.google.com/service/update2/crx" # proton pass
      "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx" # ublock origin lite
      "cimiefiiaegbelhefglklhhakcgmhkai;https://clients2.google.com/service/update2/crx" # plasma integration
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi;https://clients2.google.com/service/update2/crx" # google docs offline
    ];
    extraOpts = {
      "WebAppInstallForceList" = [
        {
          "custom_name" = "Youtube";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://youtube.com";
        }
        {
          "custom_name" = "Youtube Music";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://music.youtube.com";
        }
        {
          "custom_name" = "GitHub";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://github.com";
        }
        {
          "custom_name" = "ChatGPT";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://chatgpt.com";
        }
        {
          "custom_name" = "Whatsapp Web";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://web.whatsapp.com";
        }
        {
            "custom_name" = "LeetCode";
            "create_desktop_shortcut" = true;
            "default_launch_container" = "window";
            "url" = "https://leetcode.com";
        }
        {
            "custom_name" = "Gmail";
            "create_desktop_shortcut" = true;
            "default_launch_container" = "window";
            "url" = "https://mail.google.com";
        }
        {
          "custom_name" = "Google Drive";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://drive.google.com";
        }
      ];
    };
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    ghostty
    distrobox
    boxbuddy
    quantum-espresso
    vesta-viewer
    fastfetch
    vlc
    yazi
    vscode
    python3
    chromium
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
