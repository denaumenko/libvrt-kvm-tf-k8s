resource "libvirt_domain" "k8s_master_1" {
  name = var.master_hostname

  memory = var.master_memory
  vcpu   = var.master_vcpu


  disk {
    volume_id = libvirt_volume.master.id
    scsi      = "true"
  }

  network_interface {
    macvtap = var.network_interface
  }

  cloudinit = libvirt_cloudinit_disk.master.id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

resource "libvirt_domain" "k8s_workers" {
  count = var.workers_count
  name  = "${var.worker_hostname}-${count.index + 1}-terraform"

  memory = var.workers_memory
  vcpu   = var.workers_vcpu


  disk {
    volume_id = libvirt_volume.worker[count.index].id
    scsi      = "true"
  }

  network_interface {
    macvtap = var.network_interface
  }

  cloudinit = libvirt_cloudinit_disk.worker[count.index].id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
