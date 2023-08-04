terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "AdministratorAccess-446559390680"
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"

  subnets = ["${module.vpc.subnet1-id}", "${module.vpc.subnet2-id}", "${module.vpc.subnet3-id}"]
  vpc-id  = module.vpc.id
}

module "rds" {
  source = "./modules/rds"

  environment       = "test"
  allocated_storage = "20"
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  subnet_ids        = ["${module.vpc.subnet1-id}", "${module.vpc.subnet2-id}", "${module.vpc.subnet3-id}"]
  vpc_id            = module.vpc.id
  instance_class    = "db.t2.micro"
}

module "ecs" {
  source = "./modules/ecs"

  ecs-cluster-name            = var.ecs-cluster-name
  ecs-task-execution-role-arn = module.iam.ecs_execution_role_arn
  rds-url                     = module.rds.rds_address
  rds-username                = module.rds.rds_user
  rds-password                = module.rds.rds_password
  rds-dbname                  = var.database_name
  vpc-id                      = module.vpc.id
  rds-security-group          = module.rds.db_access_sg_id
  subnets                     = ["${module.vpc.subnet1-id}", "${module.vpc.subnet2-id}", "${module.vpc.subnet3-id}"]
  wordpress-image             = var.wordpress-image
  ecs-target-group-arn        = module.ecs.ecs-target-group-arn
}
