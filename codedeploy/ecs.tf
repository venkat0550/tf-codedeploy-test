resource "aws_ecs_cluster" "ecs_web_service" {
  name = "demo_web_service"
}


# data "template_file" "container_def_web_service" {
#   template = file("task-definitions/web_service.json")

#   vars = {
#     container_cpu = { var.container_cpu}
#     container_image = var.container_image
#   }
# }


resource "aws_ecs_task_definition" "td_web_service" {
  family                   = "web_service"
  container_definitions    = templatefile("task-definitions/web_service.json", { container_cpu = var.container_cpu, container_image = var.container_image, container_name = var.container_name, cw_log_webservice = var.cloudwatch_log_name })
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::483519012114:role/ecsTaskExecutionRole"
}

resource "aws_ecs_service" "ecs_srv_web_service" {
  name            = "webs_service"
  cluster         = aws_ecs_cluster.ecs_web_service.id
  task_definition = aws_ecs_task_definition.td_web_service.arn
  desired_count   = 1

  launch_type = "FARGATE"

  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = [module.fargate_sg.sg_id]
    assign_public_ip = true

  }


  load_balancer {
    target_group_arn = module.prod_tg_1.target_group_arn
    container_name   = "nginx-basic"
    container_port   = 80
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}

