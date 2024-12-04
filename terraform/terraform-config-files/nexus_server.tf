resource "aws_instance" "nexus_server" {
  ami                    = var.instance_ami
  instance_type          = var.sonar_nexus_instance_type
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.nexus_sg.id]
  subnet_id              = var.instance_subnet_id

  tags = {
    Name = "nexus_server"
  }
  user_data = <<-EOF
    #!/bin/bash
    # Set the hostname
    hostnamectl set-hostname nexus_server
  EOF

}
