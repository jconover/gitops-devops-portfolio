resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = concat(
    [aws_security_group.jenkins.id],
    var.security_group_ids,
  )

  iam_instance_profile = var.instance_profile
  key_name             = var.key_name
  user_data            = var.user_data

  tags = merge(var.tags, {
    Name = "${var.name}-jenkins"
  })
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "id" {
  value = aws_instance.jenkins.id
}

output "private_ip" {
  value = aws_instance.jenkins.private_ip
}
