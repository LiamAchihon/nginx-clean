output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.nginx.public_ip
}

output "ec2_eip" {
  description = "Elastic IP for Ansible"
  value       = aws_eip.eip.public_ip
}


