output "alb_arn" {
  value = aws_lb.alb_this.arn
}

output "alb_dns_name" {
  value = aws_lb.alb_this.dns_name
}
