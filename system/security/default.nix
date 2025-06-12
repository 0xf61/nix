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
  # Blacklisting unused or potentially insecure kernel modules reduces the attack surface.
  boot.blacklistedKernelModules = [
    # Network protocols (rarely used, potential attack surface)
    "ax25" "netrom" "rose"

    # Filesystems (old, rarely used, or potentially insecure network filesystems)
    "adfs" "affs" "bfs" "befs" "cramfs" "efs" "erofs" "exofs" "freevxfs"
    "f2fs" "gfs2" "hfs" "hfsplus" "hpfs" "jfs" "jffs2" "minix" "nilfs2"
    "omfs" "qnx4" "qnx6" "squashfs" "sysv" "udf"

    # Network filesystems (often handled better via userspace tools, can be a security risk)
    "cifs" "nfs" "nfsv3" "nfsv4" "ksmbd"

    # Media/debugging modules (like vivid, often unnecessary and can be a source of vulnerabilities)
    "vivid"
  ];

  # Network security
  services.networkd-dispatcher.enable = true;
}