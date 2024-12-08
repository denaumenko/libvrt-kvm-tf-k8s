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
    hostname    = "${var.worker_hostname}-${count.index}"
  }
}



data "template_file" "network_config_master" {
  template = file("${path.module}/config/network_config.yml")
}

data "template_file" "network_config_worker" {
  count    = var.workers_count
  template = file("${path.module}/config/network_config_worker${count.index}.yml")
}
