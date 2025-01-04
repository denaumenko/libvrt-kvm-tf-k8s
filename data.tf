data "local_file" "ssh_key" {
  filename = "/home/denys/.ssh/id_rsa.pub"
}

data "template_file" "user_data_master" {
  template = <<-EOF
    ${file("${path.module}/config/cloud_init_common.yml")}
    ${file("${path.module}/config/cloud_init_master.yml")}
  EOF
  vars = {
    ssh_pub_key = data.local_file.ssh_key.content
    hostname    = var.master_hostname
  }
}

data "template_file" "user_data_worker" {
  count    = var.workers_count
  template = <<-EOF
    ${file("${path.module}/config/cloud_init_common.yml")}
    ${file("${path.module}/config/cloud_init_worker.yml")}
  EOF
  vars = {
    ssh_pub_key = data.local_file.ssh_key.content
    hostname    = "${var.worker_hostname}-${count.index+1}"
  }
}



data "template_file" "network_config_master" {
  template = file("${path.module}/config/network_config_master.yml")
  vars = {
    ip_addr = var.ip_address_master
  }
}

data "template_file" "network_config_worker" {
  count    = var.workers_count
  template = file("${path.module}/config/network_config_workers.yml")
  vars = {
    ip_addr = var.ip_addressees_workers[count.index]
  }
}

data "template_file" "ansible_inventory" {
  template = <<EOF
[microk8s_HA]
master ansible_ssh_host=${var.ip_address_master}

[microk8s_WORKERS]
%{for i in range(0, length(var.ip_addressees_workers))~}
k8s-worker-${i + 1} ansible_ssh_host=${var.ip_addressees_workers[i]}
%{endfor~}

[all:vars]
ansible_ssh_user=user
ansible_ssh_private_key_file=${data.local_file.ssh_key.filename}
microk8s_version=${var.microk8s_version}
EOF
}


resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_inventory]
  content    = data.template_file.ansible_inventory.rendered
  filename   = "ansible/ansible_inventory.ini"
}


data "template_file" "gpu_passthrough" {
  template = file("${path.module}/templates/gpu_passthrough.xsl")
}
