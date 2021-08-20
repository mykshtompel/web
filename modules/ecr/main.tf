resource "aws_ecr_repository" "main" {
  name                 = "${var.app}-${var.env}-${var.name_container}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
}
EOF
}
/*
resource "null_resource" "pull_image_from_docker_hub" {
  provisioner "local-exec" {
    command = "docker image pull ${var.name_container}"
  }
}
*/

/*
resource "null_resource" "image_build" {
  provisioner "local-exec" {
    command = "docker image build ${path.module}/web/. --tag ${var.name_container}"
  }

}

resource "time_sleep" "wait_10_seconds" {
  depends_on      = [null_resource.image_build]
  create_duration = "10s"
}


resource "null_resource" "login_ecr" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }
}

resource "null_resource" "tag_image" {
  provisioner "local-exec" {
    command = "docker tag ${var.name_container}:latest ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.app}-${var.env}-${var.name_container}:latest"
  }

  depends_on = [time_sleep.wait_10_seconds]

}

resource "null_resource" "push_image" {
  provisioner "local-exec" {
    command = "docker push ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.app}-${var.env}-${var.name_container}:latest"
  }

  depends_on = [time_sleep.wait_10_seconds]
}

*/

/*
resource "null_resource" "image_build" {
  provisioner "local-exec" {
    command = "docker image build ${path.module}/web/. --tag ${var.name_container}"
  }

}
*/
/*
resource "time_sleep" "wait_10_seconds" {
  depends_on      = [null_resource.image_build]
  create_duration = "10s"
}
*/
/*
resource "null_resource" "login_ecr" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }
}

resource "null_resource" "tag_image" {
  provisioner "local-exec" {
    command = "docker tag ${var.name_container}:latest ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.app}-${var.env}-${var.name_container}:latest"
  }

  depends_on = [null_resource.image_build]

}

resource "null_resource" "push_image" {
  provisioner "local-exec" {
    command = "docker push ${local.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.app}-${var.env}-${var.name_container}:latest"
  }

  depends_on = [null_resource.image_build]
}
*/
