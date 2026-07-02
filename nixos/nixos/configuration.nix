{
  pkgs,
  lib,
  config,
  ...
}:

{

  imports = [
    ./hardware-configuration.nix
    ./modules/unstable-channel-pkgs.nix
    ./modules/nix-ld-channel-pkgs.nix
    ./modules/25.11-stable-pkgs.nix
    ./modules/virtualization.nix
    ./modules/containers.nix
    ./modules/vfio.nix
    ./modules/exclude-gnome-pkgs.nix
  ];
  documentation = {
    man.enable = true;
    doc.enable = false;
  };
  xdg.portal = {
    enable = true;

    configPackages = [ pkgs.xdg-desktop-portal-gnome ];

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "gnome" ];
      };
    };
  };

  #Enable VMWare
  virtualisation.vmware.host.package = pkgs.vmware-workstation;
  virtualisation.vmware.host.enable = true;

  #This services to using X11 gestures
  services.touchegg.enable = true;

  # Use latest Kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_7_0;
  # Use Zen Kernel
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     linux_zen = prev.linux_zen;
  #   })
  # ];

  #Enable SAMBA
  services.samba.enable = true;

  # Enable systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enabled Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Fix incorrect time when booting Windows (use when dual boot)
  # time.hardwareClockInLocalTime = true;

  networking.hostName = "NixOS"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  #Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable/Set Default Zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

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

  # Enable InputMethod Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-m17n
      kdePackages.fcitx5-unikey
    ];
  };

  # Enable OpenGL accelerate for Gamming
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime-legacy1 # for previous generations Intel 11, 9, 8
      intel-media-driver
      mesa
      xf86-video-intel
      vpl-gpu-rt # or intel-media-sdk for QSV
    ];
  };
  programs.gamemode.enable = true; # Enable pejrformance for Gamming

  # Singbox - VPN service
  services.sing-box.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.xserver.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];
  # Enable the X11 windowing system.
  services.desktopManager.gnome = {
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  environment.sessionVariables = {
    MUTTER_DEBUG_ENABLE_FRACTIONAL_SCALING = "1";
  };

  #Enable the KDE Desktop Environment
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # Fix conflict when install GNOME/KDE alongside
  ## Use this for the kssshaskpass
  # programs.ssh.askPassword = lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";
  ## or this for seahorse
  # programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # Install Displaylink Driver
  # services.xserver.videoDrivers = [ "displaylink" "modesetting" ]; this oftion do not work with latest kernel

  ## Run binaries of different architecture
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # Enable Flatpak
  # services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  # Enable Teamviewer services
  services.teamviewer.enable = true;

  # Enable sound with Pipewire.
  services.pulseaudio.enable = false; # turn off Pulse audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwdstable’.
  # users.users.hiengyen.group = "hiengyen";
  # users.groups.hiengyen = { };

  users.users.hiengyen = {
    isNormalUser = true;
    description = "hiengyen";
    extraGroups = [
      "sudo"
      "networkmanager"
      "wheel"
      "libvirtd"
      "dialout"
      "audio"
      "kvm"
    ];
  };

  # Install Browsers : firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "cursor"
    ];
  # nixpkgs.config = {
  #   allowUnfree = true;
  #   allowUnsupportedSystem = true;
  # };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  ### List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # listenAddresses = [
    #   { addr = "192.168.1.20"; port = 22; }
    #   { addr = "192.168.1.10"; port = 22; }
    # ];
  };

  # Enable Wireguard
  # enable NAT
  # networking.nat.enable = true;
  # networking.nat.externalInterface = "enp0s20f0u1";
  # networking.nat.internalInterfaces = [ "wg0" ];
  # networking.wireguard.interfaces = {
  #   # "wg0" is the network interface name. You can name the interface arbitrarily.
  #   wg0 = {
  #     # Determines the IP address and subnet of the server's end of the tunnel interface.
  #     ips = [ "10.0.0.1/24" ];
  #
  #     # The port that WireGuard listens to. Must be accessible by the client.
  #     listenPort = 51820;
  #
  #     # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
  #     # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
  #     postSetup = ''
  #       ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s20f0u1 -j MASQUERADE
  #     '';
  #     # This undoes the above command
  #     postShutdown = ''
  #       ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp0s20f0u1 -j MASQUERADE
  #     '';
  #
  #     # Path to the private key file.
  #     #
  #     # Note: The private key can also be included inline via the privateKey option,
  #     # but this makes the private key world-readable; thus, using privateKeyFile is
  #     # recommended.
  #     privateKeyFile = "/etc/wireguard/server_private.key";
  #
  #     peers = [
  #       # List of allowed peers.
  #       { # Feel free to give a meaningful name
  #         # Public key of the peer (not a file path).
  #         publicKey = "yd1YcjVF/25CxQshRAIy13hv0CUtyRP5xLOlilzlD0o=";
  #         # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
  #         allowedIPs = [ "10.0.0.2/32" ];
  #       }
  #       # { # John Doe
  #       #   publicKey = "{john doe's public key}";
  #       #   allowedIPs = [ "10.100.0.3/32" ];
  #       # }
  #     ];
  #   };
  # };
  # Like LittleSnitch on MacOS
  # services.opensnitch.enable = true;
  # Open ports in the firewall.
  # networking.nameservers = [
  #   "8.8.8.8"
  #   "1.1.1.1"
  # ];
  # networking.networkmanager.insertNameservers = [
  #   "8.8.8.8"
  #   "1.1.1.1"
  # ];
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      # KDE Connect
    ];
    allowedTCPPorts = [
      2283
      1883
      80
      443
      22
      23
      4000
      51820
      8080
    ];
    allowedUDPPorts = [
      2283
      1883
      80
      443
      22
      23
      4000
      51820
      8080
    ];
  };

  system.stateVersion = "25.11";
}
