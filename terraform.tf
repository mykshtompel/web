terraform {
  required_version = "= 1.0.2"

  backend "s3" {
    bucket  = "bucket-web-dev-nginx-us-east-2"
    key     = "live/dev/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.55"
    }
  }
}
