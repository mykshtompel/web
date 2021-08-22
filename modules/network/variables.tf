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
  description = "The AWS region for the project"
  default     = "us-east-2"
}

variable "aws_profile" {
  description = "aws profile"
}
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
  number_public_subnets  = 2
  number_private_subnets = 1
  azs                    = data.aws_availability_zones.available.names
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

#Variables for ECR
data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

variable "name_container" {
  description = "The container name"
  default     = "nginx"
}

#Variables for ECS
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default     = "TaskRole"
}

variable "web_server_image" {
  description = "The web server image to run in the ECS cluster"
  default     = "447854022972.dkr.ecr.us-east-2.amazonaws.com/my_app-test-nginx"
}

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




variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
}

locals {
  image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}

variable "taskdef_template" {
  default = "cb_app.json.tpl"
}

variable "remote_state_bucket" {}
