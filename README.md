## OpenStack Image Generator
The intent of this project is to automate and standardize the creation of virtual machine images. Initially, this project will focus on creating OpenStack images. Future plans for this project is to have options of creating images for other cloud platforms (e.g. EC2). Also, the initial goals of the project is:
  * Simple configuration
  * Well documented
  * Transferable - no project or program specific configuration, configuration should be provided by the user
  * Developer friendly - should be easy to setup and use
  

## Developer Installation ##
This project makes use of VirtualBox VMs managed by Vagrant. The resulting VM is used as a host for running [Packer](https://www.packer.io) and [Ansible](https://www.ansible.com). This method of using a VM host for Packer builds is provided for convenience. A developer or developer team may wish to install Packer and Ansible manually in a separate development VM or environment.
  1. Install VirtualBox with guest additions
  1. Install [Vagrant](https://www.vagrantup.com)
  1. Install vagrant-vbguest plugin
  1. Get ubuntu/xenial64 Vagrant box
  
     ```bash
     vagrant box add ubuntu/xenial64
     ```
     
  1. Create a new repo from an archive of this repo
  1. `vagrant up`
  1. `vagrant ssh`

**DONE!**


## Usage ##

 1. Obtain the *.sh script containing the environment variables needed to run commands against the OpenStack deployment and project for which you want to create an image. (For example, click the button that reads 'Download OpenStack RC File v2.0' in OpenStack Horizon)
 1. Source the file in step 1, providing the password for the account referenced in the RC file
 1. Update any parameters in the openstack-base.json file
 1. Update any parameters in the playbook.yml file
 1. `packer validate --var-file=openstack-vars.json openstack-base.json`
 1. If previous step passes, `packer build --var-file=openstack-vars.json openstack-base.json`
 
 ## Adding Provisioning with Ansible ##
 Ansible is installed on the Vagrant VM. Packer can be configured to provision OpenStack images using Ansible playbooks. For this project, add Ansible provisioners AFTER the shell provisioner that runs `pre-ansible.sh`. The following is a snippet showing the introduction of an Ansible `playbook.yml`.
 
 ```yaml
...
"provisioners": [
        {
            "type": "shell",
            "script": "./pre-ansible.sh"
        },

        {
            "type": "ansible",
            "playbook_file": "./playbook.yml",
            "user": "ubuntu"
        }
    ],
...
 ```
 
 The intent is to manage the base configuration of the VM images. In this way, playbooks can be added to the configuration management system and tracked as any other code artifact. 
