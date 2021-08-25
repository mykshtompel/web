variable "working_dir" {
  type    = string
  default = ""
}

variable "image_tag" {
  type    = string
  default = "0.0.1"
}

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
