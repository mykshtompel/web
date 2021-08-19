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

variable "env" {
  type    = string
  default = "stage"
}

variable "app" {
  type    = string
  default = "app"
}

variable "name_container" {
  description = "The container name"
  default     = "nginx"
}

variable "image_tag" {
  type = string
}


variable "aws_account" {
  type = string
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
