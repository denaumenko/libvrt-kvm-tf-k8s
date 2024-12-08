variable "workers_count" {
  default = 2
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
  default     = 4
}

variable "workers_memory" {
  description = "Size of RAM for worker nodes."
  default     = 16384
}

variable "workers_vcpu" {
  description = "Number of CPU cores for worker nodes."
  default     = 4
}

variable "master_volume_size" {
  description = "Size of Disk space for master node."
  default     = 15000000512
}

variable "workers_volume_size" {
  description = "Size of Disk space for worker nodes."
  default     = 15000000512
}

variable "base_image" {
  default = "http://cloud-images.ubuntu.com/releases/server/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}
