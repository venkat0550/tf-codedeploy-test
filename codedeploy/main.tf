provider "aws" {
  region = "us-east-1"
  #shared_credentials_file = "%USERPROFILE%\\.aws\\credentials"
  profile = "personal"

  # assume_role {
  #   # The role ARN within Account B to AssumeRole into. Created in step 1.
  #   role_arn = "arn:aws:iam::483519012114:role/R-Admin"
  #   # (Optional) The external ID created in step 1c.
  #   # external_id = "my_external_id"
  # }
}


terraform {
  backend "s3" {
    # Replace this with your bucket name
    bucket = "venkat200550statestore"
    key    = "codedeploytesting.tfstate"
    region = "us-east-1" # Replace this with your DynamoDB table name!
    # dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
    profile = "personal"
  }
}

data "aws_caller_identity" "current" {}



module "alb_sg" {
  source         = "../modules/SG"
  vpc_id         = var.vpc_id
  sg_name        = "sg_alb"
  sg_description = "SG for ALB traffic"
  sg_tag_name    = "alb_sg"
  sg_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    },
    {
      from_port   = 81
      to_port     = 81
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    }
  ]
}


module "alb" {
  source             = "../modules/ALB"
  vpc_id             = var.vpc_id
  security_group_ids = [module.alb_sg.sg_id]
  alb_name           = var.alb_name
  subnet_ids         = var.subnets
  alb_tag_name       = var.alb_name
}

module "cw_log_group" {
  source            = "../modules/CLOUDWATCH"
  cw_log_group_name = var.cloudwatch_log_name
}

module "fargate_sg" {
  source         = "../modules/SG"
  vpc_id         = var.vpc_id
  sg_name        = "sg_fargate"
  sg_description = "SG for fargate traffic"
  sg_tag_name    = "fargate_sg"
  sg_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    },
    {
      from_port   = 81
      to_port     = 81
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    }
  ]
}


module "prod_tg_1" {
  source                = "../modules/TG"
  target_group_name     = "tg-prod"
  vpc_id                = var.vpc_id
  target_group_port     = 80
  target_type           = "ip"
  target_group_protocol = "HTTP"

}

module "test_tg_1" {
  source                = "../modules/TG"
  target_group_name     = "tg-test"
  vpc_id                = var.vpc_id
  target_group_port     = 81
  target_type           = "ip"
  target_group_protocol = "HTTP"

}


module "listener_80" {
  source            = "../modules/ALB/LISTENER"
  lb_arn            = module.alb.alb_arn
  listener_port     = "80"
  listener_protocol = "HTTP"
  tg_arn            = module.prod_tg_1.target_group_arn
  listener_path     = "/"
}

module "listener_81" {
  source            = "../modules/ALB/LISTENER"
  lb_arn            = module.alb.alb_arn
  listener_port     = "81"
  listener_protocol = "HTTP"
  tg_arn            = module.test_tg_1.target_group_arn
}

