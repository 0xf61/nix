{

 disko.devices = {

   disk = {

     main = {

       type = "disk";

       device = "/dev/nvme0n1";

       content = {

         type = "gpt";

         partitions = {

           ESP = {

             size = "512M";

             type = "EF00";

             content = {

               type = "filesystem";

               format = "vfat";

               mountpoint = "/boot";

               mountOptions = [ "umask=0077" ];

             };

           };

           luks = {

             size = "100%";

             content = {

               type = "luks";

               name = "crypted";

               extraOpenArgs = [

                 "--allow-discards"

                 "--perf-no_read_workqueue"

                 "--perf-no_write_workqueue"

               ];

               settings = {

                 allowDiscards = true;

               };

               content = {

                 type = "btrfs";

                 extraArgs = [ "-L" "nixos" "-f" ];

                 subvolumes = {

                   "/root" = {

                     mountpoint = "/";

                     mountOptions = [

           "subvol=root"

                       "compress=zstd"

                       "noatime"

                     ];

                   };

                   "/home" = {

                     mountpoint = "/home";

                     mountOptions = [

           "subvol=home"

                       "compress=zstd"

                       "noatime"

                     ];

                   };

                   "/nix" = {

                     mountpoint = "/nix";

                     mountOptions = [

                       "subvol=nix"

                       "compress=zstd"

                       "noatime"

                     ];

                   };

                 };

               };

             };

           };

         };

       };

     };

   };

 };

}

