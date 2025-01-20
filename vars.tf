variable "workers_count" {
  default = 4
}

variable "ip_address_master" {
  description = "The ip address of master node."
  default     = "10.0.0.55"
}

variable "ip_addressees_workers" {
  description = "The list of ip addresses for worker nodes."
  default = [
    "10.0.0.56",
    "10.0.0.57",
    "10.0.0.58",
    "10.0.0.59"
  ]
}

variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/media/denys/VM/kvm-kubernetes"
}

variable "master_hostname" {
  description = "master node hostname"
  default     = "k8s-master-1-terraform"
}

variable "worker_hostname" {
  description = "master node hostname"
  default     = "k8s-worker"
}

variable "master_memory" {
  description = "Size of RAM for master node."
  default     = 16384
}

variable "master_vcpu" {
  description = "Number of CPU cores for master node."
  default     = 6
}

variable "workers_memory" {
  description = "Size of RAM for worker nodes."
  default     = 40960
}

variable "workers_vcpu" {
  description = "Number of CPU cores for worker nodes."
  default     = 6
}

variable "master_volume_size" {
  description = "Size of Disk space for master node in bytes."
  default     = 107374182400
}

variable "workers_volume_size" {
  description = "Size of Disk space for worker nodes in bytes."
  default     = 107374182400
}

variable "base_image" {
  default = "http://cloud-images.ubuntu.com/releases/server/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "microk8s_version" {
  default = "1.31/stable"
}

variable "network_interface" {
  default = "enp14s0"
}

variable "gpu_node" {
  default = 4
}
