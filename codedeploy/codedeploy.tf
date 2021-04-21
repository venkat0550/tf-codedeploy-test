
resource "aws_codedeploy_app" "cd_webservice_app" {
  compute_platform = "ECS"
  name             = "demo-webservice"
}

resource "aws_iam_role" "role_webservice_app" {
  name = "R-CodeDeploy_Webservice"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.role_webservice_app.name
}


resource "aws_codedeploy_deployment_group" "dg_webservice_app" {
  app_name               = aws_codedeploy_app.cd_webservice_app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "demo-dg-webservice"
  service_role_arn       = aws_iam_role.role_webservice_app.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "STOP_DEPLOYMENT"
      wait_time_in_minutes = "10"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.ecs_web_service.name
    service_name = aws_ecs_service.ecs_srv_web_service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [module.listener_80.aws_lb_listener_arn]
      }

      test_traffic_route {
        listener_arns = [module.listener_81.aws_lb_listener_arn]
      }
      target_group {
        name = module.prod_tg_1.target_group_name
      }

      target_group {
        name = module.test_tg_1.target_group_name
      }
    }

  }



}