resource "aws_iam_role" "ansible_ec2_role" {
  name = "ansible-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "secretsmanager_full_access" {
  name        = "SecretsManagerFullAccessPolicy"
  description = "Allows full access to Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "secretsmanager:*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secretsmanager_policy" {
  role       = aws_iam_role.ansible_ec2_role.name
  policy_arn = aws_iam_policy.secretsmanager_full_access.arn
}

resource "aws_iam_instance_profile" "ansible_instance_profile" {
  name = "ansible-instance-profile"
  role = aws_iam_role.ansible_ec2_role.name
}


resource "aws_instance" "ansible_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ansible_instance_profile.name

  tags = {
    Name = "ansible_server"
  }

  user_data = <<-EOF
  #!/bin/bash
  exec > >(tee -a /var/log/ansible_user_data.log) 2>&1

  # Set the hostname
  hostnamectl set-hostname ansible_server

  # Update the system
  yum update -y

  # Install Python 3.11
  yum install -y python3.11

  # Verify Python installation
  python3.11 --version

  # Install pip for Python 3.11
  yum install -y python3.11-pip

  # Verify pip installation
  pip3.11 --version

  # Install Ansible
  pip3.11 install ansible

  # Verify Ansible installation
  ansible --version

  # Install additional dependencies for AWS modules
  pip3.11 install boto3 botocore

  # Install jq for parsing Secrets Manager output
  yum install -y jq

  # Create /etc/ansible directory
  mkdir -p /etc/ansible

  # Retrieve private key from Secrets Manager and save it securely
  aws secretsmanager get-secret-value \
    --secret-id project-key \
    --query 'SecretString' \
    --output text \
    --region us-east-1 | jq -r '.private_key' > /etc/ansible/project-key

  # Set strict permissions on the private key
  chmod 400 /etc/ansible/project-key

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
  54.92.174.9 ansible_ssh_user=ec2-user ansible_private_key_file=project-key  ## Jenkins_server

  [servers]
  35.171.187.34 ansible_ssh_user=ec2-user ansible_private_key_file=project-key   ## Monolithic_server
  54.210.119.130 ansible_ssh_user=ec2-user ansible_private_key_file=project-key  ## Nexus_server
  54.226.121.37 ansible_ssh_user=ec2-user ansible_private_key_file=project-key   ## Sonarqube_server
  54.84.79.83 ansible_ssh_user=ec2-user ansible_private_key_file=project-key     ## Prometheus_server
  3.89.135.195 ansible_ssh_user=ec2-user ansible_private_key_file=project-key    ## Grafana_server
  EOH

  # Test Ansible installation
  ansible localhost -m ping

EOF

}
