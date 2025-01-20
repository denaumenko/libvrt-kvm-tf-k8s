# README: Access Isolated Macvtap Nodes

This guide explains how to configure access to isolated `macvtap` nodes by adding custom routing rules to the system's route table. 
Since macvtap isolates traffic between virtual interfaces and the underlying physical interface (e.g., `enp14s0`), 
custom routes need to be added for proper communication.

## Prerequisites

1. You should have `macvtap` interfaces set up and isolated from the main physical network interface (e.g., `enp14s0`).
2. You should have `wlp13s0` as the interface you will use for routing to the isolated node (e.g., `10.0.0.62`).
3. Administrative privileges (i.e., `sudo` access) are required to modify the routing table.

## Problem

By default, `macvtap` interfaces isolate traffic from the underlying physical network interface. 
For example, a macvtap interface (`macvtap0`) might be configured on `enp14s0`, but any traffic destined 
for a node that is connected to the macvtap interface won't be routed through the physical interface by default.

## Solution

To access a node (e.g., `10.0.0.55`) connected to a macvtap interface from another interface (e.g., `wlp13s0`), 
you need to manually add the correct routes to the route table. You will need to add a specific route for the isolated node. 
This ensures that any traffic destined for the node (e.g., `10.0.0.55/32`) will be directed through the correct interface (`wlp13s0`), 
bypassing the isolation caused by the `macvtap` interface.

### Option 1: Steps to Add Routes(Manually)

1. **Open a terminal** window on the host machine where the routes need to be added.

2. **Add the route to the route table** using the following `ip` command:

```bash
sudo ip route add 10.0.0.55/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.56/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.57/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.58/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.59/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.60/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.61/32 dev wlp13s0 metric 10
sudo ip route add 10.0.0.62/32 dev wlp13s0 metric 10
```

### Option 2: Steps to Add Routes(Automatically via Ansible)

1. Run the `ansible-playbook playbooks/manage_localhost_route_table_to_access_nodes.yml --extra-vars "action=add"  --ask-become-pass` command inside
`ansible` dir of the root repository.
