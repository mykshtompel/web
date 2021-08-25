module "s3_terraform_state" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
  table_name  = var.table_name
}

module "elastic_container_registry" {
  source         = "../../modules/ecr"
  app            = var.app
  env            = var.env
  name_container = var.name_container
}

module "initial_build" {
  source         = "../../modules/init-build"
  working_dir    = "${path.root}/app"
  image_tag      = var.image_tag
  app            = var.app
  env            = var.env
  name_container = var.name_container
}

module "network" {
  source                    = "../../modules/network"
  cidr_block                = "10.10.0.0/16"
  aws_dns                   = true
  app_port                  = var.app_port
  taskdef_template          = "${path.root}/../../modules/network/web_server.json.tpl"
  web_server_count          = var.web_server_count
  web_server_fargate_cpu    = var.web_server_fargate_cpu
  web_server_fargate_memory = var.web_server_fargate_memory
  aws_ecr_repository_url    = module.elastic_container_registry.aws_ecr_repository_url
  image_tag                 = var.image_tag
  app                       = var.app
  env                       = var.env
  name_container            = var.name_container
}

module "codebuild" {
  source             = "../../modules/codebuild"
  vpc_id             = module.network.vpc_id
  subnets            = module.network.private_subnet_ids
  github_oauth_token = var.github_oauth_token
  repo_url           = var.repo_url
  branch_pattern     = var.branch_pattern
  git_trigger_event  = var.git_trigger_event
  build_spec_file    = "${path.root}/config/buildspec_dev.yml"
  app                = var.app
  env                = var.env
  name_container     = var.name_container
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
