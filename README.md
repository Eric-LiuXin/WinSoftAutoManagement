## Overview

[Ansible](http://www.ansible.com.cn/) by default manages machines over the SSH protocol.

[Chocolatey](https://chocolatey.org/docs) is software management automation for Windows.

## Usage

1. Get Managed Machine

    Get windows machine (docker or vagrant).

    Add it's IP to the file named hosts.

2. Run Bootstrap

    Copy Bootstrap.ps1 to windows machine(managed), start Powershell, run

    Set-ExecutionPolicy Unrestricted -Force; .\Bootstrap.ps1

3. Build Ansible Env

    run: docker build -t ansible_env .

4. Run Ansible

    run: docker run ansible_test /bin/bash -c "ansible-playbook playbook.yaml"
