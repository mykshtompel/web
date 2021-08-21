/*
module "s3_terraform_state" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}
*/
module "network" {
  source = "./modules/network"

  cidr_block        = "10.10.0.0/16"
  aws_dns           = true
  env               = var.env
  app               = var.app
  app_port          = 80
  app_target_port   = 80
  health_check_path = "/"
  name_container    = var.name_container
  #web_server_image          = var.web_server_image
  image_tag                 = var.image_tag
  ecr_repository_url        = module.ecr.aws_ecr_repository_url
  taskdef_template          = "${path.root}/modules/network/cb_app.json.tpl"
  web_server_count          = 1
  web_server_fargate_cpu    = 256
  web_server_fargate_memory = 512
}



module "ecr" {
  source = "./modules/ecr"
  #aws_region  = var.aws_region
  #aws_profile = var.aws_profile
  #remote_state_bucket = var.bucket_name
  env              = var.env
  app              = var.app
  name_container   = var.name_container
  web_server_image = var.web_server_image

}

/*
module "network" {
  source = "./modules/network"

  #cidr_block = "10.10.0.0/16"
  #aws_dns    = true
  env = "stage"
  app = "app"
  app_port          = 80
  app_target_port   = 8080
  health_check_path = "/"

  name_container   = "nginx"
  web_server_image = "447854022972.dkr.ecr.us-east-2.amazonaws.com/app-stage-nginx"
  #web_server_count          = 1
  #web_server_fargate_cpu    = 256
  #web_server_fargate_memory = 512

}
*/

module "init-build" {
  source      = "./modules/init-build"
  aws_region  = var.aws_region
  aws_profile = var.aws_profile
  #remote_state_bucket = var.bucket_name
  env         = var.env
  app         = var.app
  working_dir = path.root
  image_tag   = var.image_tag
}
/*
module "ecs-cluster" {
    source = "../modules//cluster"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    remote_state_bucket = var.bucket_name
    environment = var.environment
    app_name = var.app_name
    image_tag = var.image_tag
    ecr_repository_url = module.ecr.ecr_repository_url
    taskdef_template = "${path.root}/../modules/cluster/cb_app.json.tpl"
    app_count = var.app_count
}
*/
module "codebuild" {
  source      = "./modules/codebuild"
  aws_region  = var.aws_region
  aws_profile = var.aws_profile
  #remote_state_bucket = var.bucket_name
  env                = var.env
  app                = var.app
  vpc_id             = module.network.vpc_id
  subnets            = module.network.private_subnet_ids
  github_oauth_token = var.github_oauth_token
  repo_url           = var.repo_url
  branch_pattern     = var.branch_pattern
  git_trigger_event  = var.git_trigger_event
  build_spec_file    = "./buildspec.yml"
}
