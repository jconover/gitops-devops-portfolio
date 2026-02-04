resource "aws_security_group" "puppet" {
  name        = "${var.name}-puppet-sg"
  description = "Security group for Puppet server"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    from_port   = 8140
    to_port     = 8140
    protocol    = "tcp"
    cidr_blocks = var.allowed_agent_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-puppet-sg"
  })
}

resource "aws_instance" "puppet" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.puppet.id]
  iam_instance_profile        = var.instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "${var.name}-puppet"
  })
}

output "public_ip" {
  value = aws_instance.puppet.public_ip
}

output "private_ip" {
  value = aws_instance.puppet.private_ip
}
