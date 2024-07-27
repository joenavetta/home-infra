
## Initialize SSD

    pvcreate /dev/sda
    vgcreate vg01 /dev/sda
    lvcreate --type thin-pool -n data01 -l 100%FREE vg01

    lvremove pve/data
    lvcreate --type thin-pool -n data00 -l 100%FREE pve


    pveum acl modify / -token 'ansible@pam!vm-admin' -role PVEVMAdmin
    pveum acl modify /storage -token 'ansible@pam!vm-admin' --role PVEDatastoreAdmin

    pveum acl modify / -token 'ansible@pam!vm-admin' --role PVEAdmin


    iptables -t nat -A PREROUTING -d 192.168.136.3 -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 8006
    
    pveum pool add infra
    
    pveum acl modify /pool/infra/ --users ansible@pam --role PVEVMAdmin
    pveum acl modify /storage/virtual-disks --users ansible@pam --role PVEDatastoreAdmin
    
    
    pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
    pveum user add terraform@pve
    pveum aclmod / -user terraform@pve -role TerraformProv
    
    terraform import proxmox_vm_qemu.omada pve-01/qemu/123
    
