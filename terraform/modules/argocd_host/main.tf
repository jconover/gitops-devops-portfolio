resource "aws_security_group" "argocd" {
  name        = "${var.name}-argocd-sg"
  description = "Security group for Argo CD host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    description = "Argo CD UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allowed_http_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-argocd-sg"
  })
}

resource "aws_instance" "argocd" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.argocd.id]
  iam_instance_profile        = var.instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "${var.name}-argocd"
  })
}

output "public_ip" {
  value = aws_instance.argocd.public_ip
}

output "private_ip" {
  value = aws_instance.argocd.private_ip
}
