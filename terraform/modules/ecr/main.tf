resource "aws_ecr_repository" "ecr_repository" {
  name                 = "${var.environment}/${var.name}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(
    var.additional_tags,
    {
      ManagedBy   = "Terraform"
      Environment = "${var.environment}"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  count = var.expiration_after_days > 0 ? 1 : 0
  repository = aws_ecr_repository.ecr_repository.name

  policy = jsonencode({
    "rules": [
      {
        "rulePriority": 1,
        "description": "Expire images older than ${var.expiration_after_days} days",
        "selection": {
          "tagStatus": "any",
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": "${var.expiration_after_days}"
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository_policy" "repo_policy" {
  for_each = aws_ecr_repository.ecr_repository

  repository = each.key

  policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "Set the permission for ECR",
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
  })
}
