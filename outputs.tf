
output "ecr_repository_url" {
  value = module.ecr.aws_ecr_repository_url
}
/*
output "alb_hostname" {
  value = module.ecs-cluster.alb_hostname
}
*/
output "confirmation" {
  value = module.init-build.confirmation
}
