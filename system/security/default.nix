{ pkgs, ... }: {
  # Hardware security
  programs.yubikey-touch-detector.enable = true;
  services.pcscd.enable = true;

  # System security
  security = {
    protectKernelImage = false;
    lockKernelModules = false;
    forcePageTableIsolation = true;
    polkit.enable = true;
    rtkit.enable = true;
    sudo.package = pkgs.sudo.override { withInsults = true; };
    
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };

  # Secure mount options
  fileSystems."/boot".options = [ "nodev" "nosuid" "noexec" ];

  # Kernel module blacklist grouped by category
  boot.blacklistedKernelModules = [
    # Network protocols (rare/insecure)
    "ax25" "netrom" "rose"
    
    # Filesystems (old/rare/network)
    "adfs" "affs" "bfs" "befs" "cramfs" "efs" "erofs" "exofs" "freevxfs"
    "f2fs" "gfs2" "hfs" "hfsplus" "hpfs" "jfs" "jffs2" "minix" "nilfs2"
    "omfs" "qnx4" "qnx6" "squashfs" "sysv" "udf"
    
    # Network filesystems
    "cifs" "nfs" "nfsv3" "nfsv4" "ksmbd"
    
    # Media/debugging
    "vivid"
  ];

  # Network security
  services.networkd-dispatcher.enable = true;
}