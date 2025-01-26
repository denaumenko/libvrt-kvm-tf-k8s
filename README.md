# libvrt-kvm-tf-k8s


1. tfswitch
2. terraform apply
2. cd ansible
3. ansible-playbook playbooks/manage_localhost_route_table_to_access_nodes.yml --extra-vars "action=add" --ask-become-pass
4. ansible-playbook playbooks/check-system-info.yml --ask-become-pass -i ansible_inventory.ini
5. ansible-playbook playbooks/gpu-driver-install.yml --ask-become-pass -i ansible_inventory.ini
6. ansible-playbook playbooks/microk8s-install.yml   --ask-become-pass -i ansible_inventory.ini
7. ansible-playbook playbooks/add_node_labels.yml   --ask-become-pass -i ansible_inventory.ini
8. ansible-playbook playbooks/enable_gpu_microk8s.yml   --ask-become-pass -i ansible_inventory.ini
9. ansible-playbook playbooks/install_go_and_kustomize_on_master.yml   --ask-become-pass -i ansible_inventory.ini
10. ansible-playbook playbooks/create_and_verify_standard_storageclass.yml   --ask-become-pass -i ansible_inventory.ini
11. ansible-playbook playbooks/base_components_preinstall_kubeflow.yml   --ask-become-pass -i ansible_inventory.ini
12. ansible-playbook playbooks/kubeflow_install.yml --ask-become-pass
13. ansible-playbook playbooks/deploy_kubeflow_ingress.yml   --ask-become-pass -i ansible_inventory.ini
14. ansible-playbook playbooks/deploy_kubeflow_ingress.yml --ask-become-pass
