output "target_group_name" {
  value       = aws_lb_target_group.tg_this.name

  description = "Target Group Name"

}

output "target_group_id" {
  value       = aws_lb_target_group.tg_this.id

  description = "Target Group Id"

}

output "target_group_arn" {
  value       = aws_lb_target_group.tg_this.arn

  description = "Target Group ARN"

}


