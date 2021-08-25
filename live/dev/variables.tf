#General variables
variable "aws_profile" {
  type    = string
  default = "default"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

#Variables for module "s3_terraform_state"
variable "bucket_name" {
  type    = string
  default = "bucket-web-dev-nginx-us-east-2"
}

variable "table_name" {
  type    = string
  default = "table-web-dev-nginx-us-east-2"
}

#Variables for module "elastic_container_registry", module "initial_build"
variable "env" {
  type    = string
  default = "dev"
}

variable "app" {
  type    = string
  default = "web"
}

variable "name_container" {
  type    = string
  default = "nginx"
}

#Variables for module "initial_build"
variable "working_dir" {
  type    = string
  default = ""
}

variable "image_tag" {
  type    = string
  default = "0.0.1"
}

#Variables for module "network"
variable "cidr_block" {
  description = "The CIDR block of the project"
  default     = "10.0.0.0/16"
}

variable "app_port" {
  description = "The application port"
  default     = 80
}

variable "taskdef_template" {
  default = "web_server.json.tpl"
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

#Variables for module "codebuild"
variable "github_oauth_token" {
  type    = string
  default = ""
}

variable "repo_url" {
  type    = string
  default = "https://github.com/mykshtompel/web"
}

variable "branch_pattern" {
  type    = string
  default = "^refs/heads/dev$"
}

variable "git_trigger_event" {
  type    = string
  default = "PUSH"
}

/*
variable "aws_account" {
  type    = string
  default = "480681066960"
}

variable "env" {
  type    = string
  default = "stage"
}

variable "app" {
  type    = string
  default = "app"
}

variable "name_container" {
  default = "nginx"
}
*/
/*
variable "web_server_image" {
  default = "480681066960.dkr.ecr.us-east-2.amazonaws.com/my_app-test-nginx"
}

variable "image_tag" {
  type    = string
  default = "0.0.1"
}


variable "github_oauth_token" {
  type    = string
  default = ""
}

variable "repo_url" {
  type    = string
  default = ""
}

variable "branch_pattern" {
  type    = string
  default = ""
}

variable "git_trigger_event" {
  type    = string
  default = ""
}

variable "app_count" {
  default = 1
}
*/
