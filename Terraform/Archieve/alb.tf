module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "venkat-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpcid
  subnets            = [module.vpc.public_subnet[0], module.vpc.public_subnet[1]]
  security_groups    = [module.alb_service_sg.security_group_ids]

  access_logs = {
    bucket = "alb-logs"
  }

  target_groups = [
    {
      name_prefix      = "jenkins"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.jenkins_instance.instance_id
          port = 8080
        }
      }
      health_check = {
        enabled             = true
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        path                = "/jenkins"
        matcher             = "200-399"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  http_listener_rules = [
    {
      https_listener_index = 0
      priority             = 1

      actions = [{
        type        = "redirect"
        path        = "/jenkins"
        protocol    = "HTTP"
      }]
    }
  ]

  tags = {
    Environment = "Test"
  }
}