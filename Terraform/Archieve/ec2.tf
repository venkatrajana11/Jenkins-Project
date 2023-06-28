module "bastion_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                      = "bastion-instance"
  ami                       = "ami-053b0d53c279acc90"
  instance_type             = "t2.micro"
  key_name                  = aws_key_pair.terraform-keypair.key_name
  monitoring                = true
  vpc_security_group_ids    = [module.pub_service_sg.security_group_id]
  subnet_id                 = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "venkat-assignment-bastion"
    Server      = "Bastion"
  }
}

module "jenkins_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                      = "jenkins-instance"
  ami                       = "ami-053b0d53c279acc90"
  instance_type             = "t2.micro"
  key_name                  = aws_key_pair.terraform-keypair.key_name
  monitoring                = true
  vpc_security_group_ids    = [module.priv_service_sg.security_group_id]
  subnet_id                 = module.vpc.private_subnets[0]
  associate_public_ip_address = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "venkat-assignment-jenkins"
    Server      = "Jenkins"
  }
}

module "app_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                      = "app-instance"
  ami                       = "ami-053b0d53c279acc90"
  instance_type             = "t2.micro"
  key_name                  = aws_key_pair.terraform-keypair.key_name
  monitoring                = true
  vpc_security_group_ids    = [module.priv_service_sg.security_group_id]
  subnet_id                 = module.vpc.private_subnets[1]
  associate_public_ip_address = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "venkat-assignment-app"
    Server      = "app"
  }
}
