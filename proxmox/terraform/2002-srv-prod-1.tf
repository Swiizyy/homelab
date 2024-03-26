resource "proxmox_vm_qemu" "srv-prod-1" {
    name = "srv-prod-1"
    desc = "Server Production 1, Main Application Server, Ubuntu LTS"
    agent = 1
    qemu_os = "other"  # default other
    bios = "seabios"  # default=ovmf
    tags = "docker"

    define_connection_info = false

    # -- only important for full clone
    # vmid = 20002
    # clone = "ubuntu-server-test-1"
    # full_clone = true
    full_clone = false

    # -- boot process
    onboot = true
    startup = ""
    automatic_reboot = false  # refuse auto-reboot when changing a setting

    cores = 3
    sockets = 1
    cpu = "host"
    memory = 6144

    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci

    # disk {
    #     storage = "pv1"
    #     type = "virtio"
    #     size = "40G"
    #     iothread = 1
    # }

    # -- lifecycle
    lifecycle {
        ignore_changes = [
            disk,
            vm_state
        ]
    }
    
    # Cloud Init Settings 
    ipconfig0 = "ip=192.168.1.12/24,gw=192.168.1.1"
    nameserver = "192.168.1.1"
    ciuser = "swiizyy"
    sshkeys = var.PUBLIC_SSH_KEY
}