resource "aws_iam_role" "monolithic_ec2_role" {
  name = "monolithic-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "monolithic_secretsmanager_policy" {
  name        = "MonolithicSecretsManagerAccess"
  description = "Allow EC2 to access Secrets Manager for monolithic app"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*" 
        # Replace "*" with the specific ARN if you want stricter access:
        # "arn:aws:secretsmanager:us-east-1:<account-id>:secret:itgenius-db-secret*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_monolithic_secrets_policy" {
  role       = aws_iam_role.monolithic_ec2_role.name
  policy_arn = aws_iam_policy.monolithic_secretsmanager_policy.arn
}

resource "aws_iam_instance_profile" "monolithic_instance_profile" {
  name = "monolithic-instance-profile"
  role = aws_iam_role.monolithic_ec2_role.name
}

resource "aws_instance" "monolithic_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.monolithic_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.monolithic_instance_profile.name

  tags = {
    Name = "monolithic_server"
  }

  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname monolithic_server
  EOF
}
