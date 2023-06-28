module "pub_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "venkat-pub-sg"
  description = "Security group for bastion with custom ports open within VPC publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh-security ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = [
    "all-all"
  ]
}

module "priv_service_sg" {
  source = "terraform-aws-modules/security-group/aws"
  
  name        = "venkat-priv-sg"
  description = "Security group for Jenkins & app accessible within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All traffic"
      cidr_blocks = "10.0.0.0/16"
    },
  ]
  egress_rules = [
    "all-all"
  ]
}

module "alb_service_sg" {
  source = "terraform-aws-modules/security-group/aws"
  
  name        = "venkat-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

