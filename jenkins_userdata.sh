#!/bin/bash

# Redirect all stdout and stderr to a log file
exec > >(tee /var/log/jenkins-setup.log | logger -t user-data -s) 2>&1

echo "==== Starting Jenkins setup ===="

# Update all packages
echo "Updating packages..."
yum update -y

# Add Jenkins repo
echo "Adding Jenkins repo..."
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import the Jenkins GPG key
echo "Importing Jenkins GPG key..."
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade packages again after adding the repo
echo "Upgrading packages..."
yum upgrade -y

# Install Java (Amazon Corretto 17)
echo "Installing Java..."
yum install java-17-amazon-corretto -y

# Install Jenkins
echo "Installing Jenkins..."
yum install jenkins -y

# Enable Jenkins to start at boot
echo "Enabling Jenkins..."
systemctl enable jenkins

# Start Jenkins service
echo "Starting Jenkins..."
systemctl start jenkins

# Print Jenkins status
echo "Checking Jenkins status..."
systemctl status jenkins


# === Install Terraform
cd /tmp
TERRAFORM_VERSION="1.12.2"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/
chmod +x /usr/local/bin/terraform

# Ensure /usr/local/bin is in PATH for all users
echo 'export PATH=$PATH:/usr/local/bin' >> /etc/profile
export PATH=$PATH:/usr/local/bin
terraform -v

ln -s /usr/local/bin/terraform /usr/bin/terraform

#Install python 3.8
sudo yum install gcc openssl-devel bzip2-devel libffi-devel -y
cd /usr/src
sudo curl -O https://www.python.org/ftp/python/3.8.18/Python-3.8.18.tgz
sudo tar xzf Python-3.8.18.tgz
cd Python-3.8.18
sudo ./configure --enable-optimizations
sudo make altinstall


echo "==== Userdata setup complete ===="
