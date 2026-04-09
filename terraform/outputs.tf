output "ip_de_nestjs" {
  value = [ for i in aws_instance.mi_app_nestjs : i.public_ip ]
}
