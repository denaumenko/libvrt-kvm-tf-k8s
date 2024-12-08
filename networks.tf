resource "libvirt_network" "host_bridge" {
  name   = "host-bridge2"
  mode   = "bridge"
  bridge = "br0"
}
