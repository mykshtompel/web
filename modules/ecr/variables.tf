#General Data
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

#General Variables
variable "env" {
  description = "The environment of the project"
  default     = "test"
}

variable "app" {
  description = "The app of the project"
  default     = "my_app"
}

variable "aws_region" {
  description = "aws region"
}

variable "aws_profile" {
  description = "aws profile"
}

/*
variable "region" {
  description = "The AWS region for the project"
  default     = "us-east-2"
}
*/
/*
#Variables for Network
variable "cidr_block" {
  description = "The CIDR block of the project"
  default     = "10.0.0.0/16"
}

variable "aws_dns" {
  type    = bool
  default = true
}

locals {
  number_public_subnets = 2
  #number_private_subnets = 2
  azs = data.aws_availability_zones.available.names
  #number_bastion_servers = 2
  #number_web_servers     = 2
}

#Variables for Application Load Balancer
variable "app_port" {
  description = "The application port"
  default     = 80
}

variable "app_target_port" {
  description = "The application port"
  default     = 80
}

variable "health_check_path" {
  description = "The path for health check web servers"
  default     = "/"
}

*/
data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

variable "name_container" {
  description = "The container name"
  default     = "nginx"
}
/*
data "aws_ecr_repository" "main" {
  name = "${var.app}-${var.env}-${var.name_container}"
}
*/
/*
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}
*/
variable "web_server_image" {
  description = "The web server image to run in the ECS cluster"
  default     = "447854022972.dkr.ecr.us-east-2.amazonaws.com/my_app-test-nginx"
}
/*
variable "web_server_count" {
  description = "Number of web server containers to run"
  default     = 1
}

variable "web_server_fargate_cpu" {
  description = "Fargate instance CPU units to provision for web server (1 vCPU = 1024 CPU units)"
  default     = 256
}

variable "web_server_fargate_memory" {
  description = "Fargate instance memory to provision for web server (in MiB)"
  default     = 512
}
*/
variable "remote_state_bucket" {}
