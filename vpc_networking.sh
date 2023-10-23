#!/bin/bash

#precious1gift@gmail.com

gcloud compute networks subnets list --network default

gcloud compute routes list --filter="network=default AND priority=1000"

gcloud compute firewall-rules list

gcloud compute firewall-rules delete default-allow-icmp default-allow-rdp default-allow-ssh default-allow-internal

gcloud compute networks delete default

gcloud compute instances create demo-vm --network default
    #this command returns an Error message, confirming that a VM instance cannot be created without a VPC network!

gcloud compute networks create mynetwork --subnet-mode=auto --mtu=1460 --bgp-routing-mode=regional

gcloud compute firewall-rules create mynetwork-allow-custom --network=mynetwork --direction=INGRESS --priority=65534 --source-ranges=10.128.0.0/9 --action=ALLOW --rules=all

gcloud compute firewall-rules create mynetwork-allow-icmp --network=mynetwork --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=icmp

gcloud compute firewall-rules create mynetwork-allow-rdp --network=mynetwork --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:3389

gcloud compute firewall-rules create mynetwork-allow-ssh --network=mynetwork --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:22

gcloud compute instances create mynet-us-vm --zone=us-central1-c --machine-type=n1-standard-1 --network-interface=network-tier=PREMIUM,subnet=mynetwork 

gcloud compute instances create mynet-eu-vm --zone=europe-west1-c --machine-type=n1-standard-1 --network-interface=network-tier=PREMIUM,subnet=mynetwork

gcloud compute ssh mynet-us-vm --zone=us-central1-c --command="ping -c 3 10.132.0.2; ping -c 3 34.77.147.83"
    # this command will give a warning indicating that SSH keygen will be executed to generate a key. 
        # a directory will need to be created before being able to generate SSH keys. When promted, continue
            # next a passpharse will be requested to generate a public/private rsa key pair, press enter (for no passphrase)
                 # press enter again (for no passphrase)

gcloud compute networks update mynetwork --switch-to-custom-subnet-mode

gcloud compute networks create managementnet --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-central1

gcloud compute networks create privatenet --subnet-mode=custom

gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-central1 --range=172.16.0.0/24

gcloud compute networks subnets create privatesubnet--eu --network=privatenet --region=europe-west1 --range=172.20.0.0/20

gcloud compute networks list

gcloud compute networks subnets list --sort-by=NETWORK

gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

gcloud compute firewall-rules list --sort-by=NETWORK

gcloud compute instances create managementnet-us-vm --zone=us-central1-c --machine-type=n1-standard-1 --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us

gcloud compute instances create privatenet-us-vm --zone=us-central1-c --machine-type=f1-micro --subnet=privatesubnet-us --image-family=debian-10 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=privatenet-us-vm

gcloud compute instances list --sort-by=ZONE

gcloud compute ssh mynet-us-vm --zone=us-central1-c --command="ping -c 3 34.77.147.83; ping -c 3 34.133.90.93; ping -c 3 34.170.128.82; ping -c 3 10.132.0.2; ping -c 3 10.130.0.2; ping -c 3 172.16.0.2"