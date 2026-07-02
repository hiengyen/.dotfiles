{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # --- Standard and International Fonts ---
    noto-fonts
    noto-fonts-cjk-sans # Support for Chinese, Japanese, Korean characters
    noto-fonts-color-emoji # Support for colored emojis
    liberation_ttf # Open-source replacements for MS fonts (Arial, Times New Roman)
    corefonts # Microsoft original true type fonts
    dejavu_fonts # Open-source replacements for MS fonts
    liberation_ttf # Open-source replacements for MS fonts

    # --- Specialized & Programming Fonts ---
    mplus-outline-fonts.githubRelease
    dina-font # Bitmap font for programmers
    proggyfonts # Monospaced font for coding
    vista-fonts # Windows Vista fonts (Calibri, Consolas)
    corefonts # Microsoft original true type fonts

    # --- Nerd Fonts (Icons for Terminal/Neovim) ---
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  environment.systemPackages = with pkgs; [
    # --- Virtualization & Emulation (QEMU/KVM) ---
    # qemu # Full virtualization framework
    qemu_kvm # Lightweight virtualization framework
    OVMF # UEFI firmware for virtual machines
    qemu-utils # Disk image utilities for QEMU
    uefi-run # Run UEFI applications in QEMU
    edk2 # EFI Development Kit

    # --- SPICE Remote Desktop Protocol ---
    spice
    win-spice # SPICE guest tools for Windows
    x11spice # Remote control of an existing X11 session
    libguestfs # Tools for accessing and modifying VM disk images
    spice-vdagent # Enhanced SPICE integration for Linux guests
    virglrenderer # 3D GPU acceleration for QEMU guests
    ubootQemuX86 # Bootloader for embedded system testing
    xf86-video-intel # Intel video driver for Xorg

    virtiofsd # Shared file system for virtio-fs
    virtio-win # Windows drivers for VirtIO devices
    sdparm # SCSI device parameter utility

    # --- GNOME Desktop Extensions & Tweaks ---
    gnomeExtensions.proxy-switcher
    gnomeExtensions.caffeine # Prevent screen sleep/lock
    gnomeExtensions.vitals # System status in top bar
    gnomeExtensions.appindicator # Support for legacy tray icons
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection # UI customization tool
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gsconnect # Android integration (KDE Connect for GNOME)
    gnomeExtensions.x11-gestures
    gnomeExtensions.top-panel-workspace-scroll # Scrollable workspace switcher
    gnomeExtensions.launch-new-instance # Launch applications in new workspace
    gnome-tweaks # Advanced GNOME settings GUI

    # --- Core System & CLI Utilities ---
    uucp # Includes 'cu' command for serial console
    screen # Terminal multiplexer
    sbctl # Secure Boot key management tool
    linux-wifi-hotspot # Create Wi-Fi access points (create_ap)
    cmake # Build system generator
    pkg-config # Library configuration helper
    patchelfUnstable # Modify ELF executables (common for NixOS fixes)
    pciutils # Tool for inspecting PCI devices (lspci)
    busybox # Multi-call binary for standard Unix tools
    zip
    unzip
    unrar-wrapper
    usbutils # Tool for inspecting USB devices (lsusb)
    libinput # Input device management
    binutils-unwrapped-all-targets # Binary manipulation tools
    wirelesstools # Tools for wireless interface configuration
    btop # Modern terminal resource monitor
    hwinfo # Detailed hardware information tool
    wget # CLI network downloader
    vim # Text editor
    git # Version control
    git-xet # Xet extension for git
    gcc # GNU Compiler Collection
    gcc_multi # GCC with 32-bit and 64-bit support
    yarn # JavaScript package manager
    libgcc
    nmap # Network scanner and security auditor
    mpfr # Multiple-precision floating-point library
    gmp # Arbitrary precision arithmetic library
    libmpc # Complex number arithmetic library
    haskellPackages.gdp
    gnumake42 # GNU Make build tool
    perl # Perl programming language
    curl # CLI tool for transferring data with URLs
    wl-clipboard # Wayland clipboard utility
    xclip # X11 clipboard utility
    hyfetch # CLI system information tool
    kitty # GPU-accelerated terminal emulator
    zsh # Powerful shell
    yazi # Terminal file manager
    xsel # X11 clipboard selection tool
    poppler # PDF rendering library
    ffmpegthumbnailer # Video thumbnail generator
    jellyfin-ffmpeg # FFmpeg build for Jellyfin media server
    p7zip # 7-Zip file archiver
    openssl # Cryptography toolkit
    bluetui # TUI for Bluetooth management

    # --- Productivity & Daily Apps ---
    jq # CLI JSON processor
    imagemagick # Image manipulation suite
    distrobox # Run other Linux distros in containers
    dbeaver-bin # Universal database management GUI
    mpv # Minimalist video player
    mplayer # Classic media player
    vlc # Universal media player
    tmux # Terminal multiplexer
    tmuxifier # Tmux layout manager
    obs-studio # Video recording and streaming
    gparted # GUI partition manager
    stow # Symlink farm manager (dotfiles)
    brave # Privacy-focused web browser
    freerdp # Remote Desktop Protocol (RDP) client
    hardinfo2 # System profiler and benchmark
    # xorg.libX11

    # --- Security & Communications ---
    gnome-keyring # Password and secret management
    seahorse # GUI for managing encryption keys
    xdotool # Command-line X11 automation tool
    socat # Multipurpose relay tool (netcat on steroids)
    minicom # Serial communication program
    ntfs3g # Read/Write support for NTFS file systems

    # --- Search & Developer workflow (Lazy.nvim deps) ---
    fzf # Command-line fuzzy finder
    fzf-zsh-plugin
    fd # Fast alternative to 'find'
    ripgrep # Fast alternative to 'grep'
    luajitPackages.luarocks # Lua package manager

    # --- Themes ---
    yaru-theme # Ubuntu's default theme (GTK/Icons)

    # --- Specialized Tools (AI, Cloud, Engineering) ---
    drawio # Diagramming and flowchart tool
    gimp-with-plugins # Image editor with extra plugins
    gns3-gui # Network simulator GUI
    rustdesk-flutter # Remote desktop software

    # --- Messaging & Chat ---
    discord
    slack
    signal-desktop
    telegram-desktop
    whatsie
    viber

    # --- Programming Languages & Toolchains ---
    # Python
    python313Packages.conda
    python313
    python313Packages.pip
    python312Packages.diagrams # Diagrams as Code (Python)
    pyenv # Python version management

    # JavaScript/Node
    nodejs_22
    corepack # Shims for npm/yarn/pnpm

    # Nix Development
    # nil # Nix Language Server
    # nixfmt-rfc-style # Official Nix code formatter

    # Rust
    rustc
    rustup
    cargo

    # Java
    maven
    jdk
    jre8

    # --- Hardware & GPU Debugging ---
    lshw # List hardware
    virtualgl # 3D acceleration for remote/virtual sessions
    mesa-demos # OpenGL testing tools (glxgears)
    vulkan-tools # Vulkan info and testing (vulkaninfo)

    # --- Browsers & Networking tools ---
    lemonade # Remote clipboard tool over SSH
    google-chrome
    # gui-for-singbox # GUI for Sing-box proxy/VPN
    graphviz # Graph visualization software
    fragments # BitTorrent client
    # realvnc-vnc-viewer # VNC remote desktop client
    # zoom-us # Video conferencing

    # --- Infrastructure & System Admin (IaC) ---
    ansible # Configuration management
    winbox4 # MikroTik RouterOS management GUI
    smartmontools # HDD/SSD health monitoring (smartctl)
    localsend # Local network file sharing
    x2goclient # Remote desktop client (X2Go)
    nomachine-client # Remote desktop client (NoMachine)

    # --- Networking Low-Level ---
    libqmi # WWAN/Modem control
    iproute2 # Advanced IP routing (ip command)
    iptables # Firewall rules management
    dmidecode # Read system hardware info from BIOS (DMI)

    # --- VPN & Network Security ---
    wireguard-tools # CLI tools for Wireguard VPN
    opensnitch-ui # GUI for OpenSnitch firewall
    opensnitch # Application-level firewall service
    firejail # Namespace-based sandboxing tool for Linux
    pandoc # Markdown to PDF converter
    texliveFull

    # --- Utilities ---
    freshfetch # CLI system information tool

    # --- Office ---
    onlyoffice-desktopeditors
    onlyoffice-documentserver

    element-desktop

    # --- AI ---
    llama-cpp
    ollama
    ollama-cpu

    libxshmfence # X11 shared memory fence
  ];
}
