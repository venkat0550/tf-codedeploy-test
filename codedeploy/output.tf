output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "alb_sg_id" {
  value       = module.alb_sg.sg_id
  description = "ALB security group ID"
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name

  description = "ALB DNS Name"

}

output "alb_arn" {
  value       = module.alb.alb_arn
  description = "ALB DNS Name"
}

output "target_group_name_prod" {
  value       = module.prod_tg_1.target_group_name
  description = "Target Group Name - Prod"

}

output "target_group_name_test" {
  value       = module.test_tg_1.target_group_name
  description = "Target Group Name - Test"

}

output "target_group_arn_prod" {
  value       = module.prod_tg_1.target_group_arn
  description = "Target Group ARN - Prod"

}

output "target_group_arn_test" {
  value       = module.test_tg_1.target_group_arn
  description = "Target Group ARN - Test"

}

output "alb_listener_arn_prod" {
  value       = module.listener_80.aws_lb_listener_arn
  description = "Listener ARN - Prod"

}


output "alb_listener_arn_test" {
  value       = module.listener_81.aws_lb_listener_arn
  description = "Listener ARN - Test"

}



output "fargate_sg_id" {
  value       = module.fargate_sg.sg_id
  description = "Fargate security group ID"
}



output "cw_log_group_arn" {
  value       = module.cw_log_group.cw_log_group_arn
  description = "Cloudwatch Log Group Arn"
}
