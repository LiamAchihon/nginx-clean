output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "instance_public_ip" {
  value = aws_instance.nginx_server.public_ip
}
