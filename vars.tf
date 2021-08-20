/*
variable "bucket_name" {
  type        = string
  description = "S3 Bucket name"
  default     = "flaskapp-dev-eu-west-1"
}
*/
variable "aws_region" {
  default = "us-east-2"
}

variable "aws_profile" {
  default = "nikolayshtompel"
}

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
