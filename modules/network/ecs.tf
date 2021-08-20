#ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.app}-${var.env}-cluster"
}

#ECS task definition
resource "aws_ecs_task_definition" "web_server" {
  family                   = "${var.app}-${var.env}-${var.name_container}"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.web_server_fargate_cpu
  memory                   = var.web_server_fargate_memory
  container_definitions = jsonencode(
    [
      {
        name  = "nginx"
        image = local.image
        #image       = aws_ecr_repository.main.repository_url
        cpu         = var.web_server_fargate_cpu
        memory      = var.web_server_fargate_memory
        networkMode = "awsvpc"

        portMappings = [{
          containerPort = var.app_port
          hostPort      = var.app_port
        }]
      }
    ]
  )
}

#ECS task security group
resource "aws_security_group" "web_server_task" {
  name   = "${var.app}_${var.env}_sg_web_server_task"
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ECS service
resource "aws_ecs_service" "web_server" {
  name            = "${var.app}-${var.env}-${var.name_container}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.web_server.arn
  desired_count   = var.web_server_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.web_server_task.id]
    subnets          = aws_subnet.public_subnet.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.web_server.id
    container_name   = var.name_container
    container_port   = var.app_port
  }

  depends_on = [aws_ecs_cluster.main, aws_alb_listener.http, aws_iam_role_policy_attachment.ecs_task_execution_role, aws_security_group.web_server_task]
}
