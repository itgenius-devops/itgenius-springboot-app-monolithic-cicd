resource "aws_instance" "prometheus_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.monitoring_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "prometheus_server"
  }
  user_data = <<-EOF
      #!/bin/bash
      # Set the hostname
      hostnamectl set-hostname prometheus_server
    EOF
}
