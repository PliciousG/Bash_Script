# Bash_Script

This bash script project uses the gcloud command-line interphase to create and manage VPC networks, subnets, firewall rules, and VM instances.

This script can be used to create a basic VPC network for testing or development purposes.
It can also be used as a starting point for creating more complex networks with multiple subnets, security zones, and other features.

## Steps:
* List the subnets in the default network.
* List the routes in the default network with a priority of 1000.
* List the firewall rules in the default network.
* Delete the default firewall rules.
* Delete the default network.
* Create a new VPC network with custom subnets and a network tier of PREMIUM.
* Create firewall rules to allow ICMP, RDP, and SSH traffic to the new network.
* Create VM instances in the new network.
* Update the new network to use custom subnets.
* List the VPC networks and subnets.
* Create firewall rules to allow ICMP, RDP, and SSH traffic to the management and private networks.
* Create VM instances in the management and private networks.
* List the VM instances.
* SSH into the VM instance in the new network and ping various IP addresses to test connectivity.
