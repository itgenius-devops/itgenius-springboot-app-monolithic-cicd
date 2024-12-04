resource "aws_instance" "sonarqube_server" {
  ami                    = var.instance_ami
  instance_type          = var.sonar_nexus_instance_type
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
  subnet_id              = var.instance_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "sonarqube_server"
  }
  user_data = <<-EOF
      #!/bin/bash
      # Set the hostname
      hostnamectl set-hostname sonarqube_server
    EOF
}
