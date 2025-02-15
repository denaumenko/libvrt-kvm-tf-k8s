# libvrt-kvm-tf-k8s


1. tfswitch
2. terraform apply
2. cd ansible
3. ansible-playbook playbooks/manage-vms/manage_localhost_route_table_to_access_nodes.yml --extra-vars "action=add" --ask-become-pass
4. ansible-playbook playbooks/manage-vms/check-system-info.yml --ask-become-pass -i ansible_inventory.ini
5. ansible-playbook playbooks/drivers/gpu-driver-install.yml --ask-become-pass -i ansible_inventory.ini
6. ansible-playbook playbooks/kubernetes/microk8s-install.yml -i ansible_inventory.ini
7. ansible-playbook playbooks/kubernetes/add_node_labels.yml   --ask-become-pass -i ansible_inventory.ini
8. ansible-playbook playbooks/kubernetes/enable_gpu_microk8s.yml   --ask-become-pass -i ansible_inventory.ini



[//]: # (11. ansible-playbook playbooks/kubeflow_install.yml --ask-become-pass)
