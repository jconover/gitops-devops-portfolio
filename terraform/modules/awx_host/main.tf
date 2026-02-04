resource "aws_security_group" "awx" {
  name        = "${var.name}-awx-sg"
  description = "Security group for AWX controller"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_http_cidrs
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "${var.name}-awx-sg"
  })
}

resource "aws_instance" "awx" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.awx.id]
  iam_instance_profile        = var.instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "${var.name}-awx"
  })
}

output "public_ip" {
  value = aws_instance.awx.public_ip
}

output "private_ip" {
  value = aws_instance.awx.private_ip
}
