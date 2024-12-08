# A pool for all cluster volumes
resource "libvirt_pool" "kvm-kubernetes" {
  name = "kvm-kubernetes"
  type = "dir"
  target {
    path = var.libvirt_disk_path
  }
}

resource "libvirt_volume" "ubuntu2404" {
  name   = "ubuntu24.04"
  source = var.base_image
  pool   = libvirt_pool.kvm-kubernetes.name
  format = "qcow2"
}

# volume to attach to the "master" domain as main disk
resource "libvirt_volume" "master" {
  name           = "master.qcow2"
  base_volume_id = libvirt_volume.ubuntu2404.id
  pool           = libvirt_pool.kvm-kubernetes.name
  size           = var.master_volume_size
}

# volumes to attach to the "workers" domains as main disk
resource "libvirt_volume" "worker" {
  count          = var.workers_count
  name           = "worker_${count.index}.qcow2"
  base_volume_id = libvirt_volume.ubuntu2404.id
  pool           = libvirt_pool.kvm-kubernetes.name
  size           = var.workers_volume_size
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "master" {
  name           = "commoninit.iso"
  pool           = libvirt_pool.kvm-kubernetes.name # List storage pools using virsh pool-list
  user_data      = data.template_file.user_data_master.rendered
  network_config = data.template_file.network_config_master.rendered
}

resource "libvirt_cloudinit_disk" "worker" {
  count          = var.workers_count
  name           = "commoninit${count.index}.iso"
  pool           = libvirt_pool.kvm-kubernetes.name # List storage pools using virsh pool-list
  user_data      = data.template_file.user_data_worker[count.index].rendered
  network_config = data.template_file.network_config_worker[count.index].rendered
}

