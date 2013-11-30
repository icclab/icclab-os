# http://docs.openstack.org/network-admin/admin/content/install_neutron-lbaas-agent.html

# apt-get install neutron-lbaas-agent
# interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
# device_driver = neutron.plugins.services.agent_loadbalancer.drivers.haproxy.namespace_driver.HaproxyNSDriver
#
# neutron.conf
# service_plugins = neutron.plugins.services.agent_loadbalancer.plugin.LoadBalancerPlugin

# Class: icclab::loadbalancer
#
#
class icclab::loadbalancer {
	# resources
}