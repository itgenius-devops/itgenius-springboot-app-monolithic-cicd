resource "aws_instance" "ansible_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "ansible_server"
  }

  user_data = <<-EOF
    #!/bin/bash
    # Set the hostname
    hostnamectl set-hostname ansible_server

    # Update the system
    yum update -y

    # Install Python 3.11
    yum install -y python3.11

    # Verify Python installation (optional, for debug purposes)
    python3.11 --version

    # Install pip for Python 3.11
    yum install -y python3.11-pip

    # Verify pip installation (optional, for debug purposes)
    pip3.11 --version

    # Install Ansible
    pip3.11 install ansible

    # Verify Ansible installation (optional, for debug purposes)
    ansible --version

    # Install additional dependencies for AWS modules (optional)
    pip3.11 install boto3 botocore

    # Create /etc/ansible directory
    mkdir -p /etc/ansible

    # Create Ansible configuration file
    cat <<EOC > /etc/ansible/ansible.cfg
    [defaults]
    inventory = /etc/ansible/hosts
    remote_user = ec2-user
    log_path = /etc/ansible/ansible.log
    EOC

    # Create Ansible hosts file
    cat <<EOH > /etc/ansible/hosts
    [jenkins]
    54.92.174.9 ansible_ssh_user=ec2-user ansible_private_key_file=project-key ## Jenkins_server

    [servers]
    35.171.187.34 ansible_ssh_user=ec2-user ansible_private_key_file=project-key   ## Monolithic_server
    54.210.119.130 ansible_ssh_user=ec2-user ansible_private_key_file=project-key  ## Nexus_server
    54.226.121.37 ansible_ssh_user=ec2-user ansible_private_key_file=project-key   ## Sonarqube_server
    54.84.79.83 ansible_ssh_user=ec2-user ansible_private_key_file=project-key     ## Prometheus_server
    3.89.135.195 ansible_ssh_user=ec2-user ansible_private_key_file=project-key    ## Grafana_server
    EOH

    # Test Ansible installation
    ansible localhost -m ping > /tmp/ansible_test.log
  EOF
}
