resource "aws_ecs_task_definition" "wordpress-main" {
  family                   = "my_wordpress_test-main"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
#   container_definitions    = data.template_file.testapp.rendered
   container_definitions    = <<TASK_DEFINITION
   [
    {
      "dnsSearchDomains": null,
      "environmentFiles": null,
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "/ecs/wordpress",
          "awslogs-region": "ap-south-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ],
      "command": null,
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "WORDPRESS_DB_HOST",
          "value": "127.0.0.1:3306"
        },
        {
          "name": "WORDPRESS_DB_USER",
          "value": "exampleuser"
        },
        {
          "name": "WORDPRESS_DB_PASSWORD",
          "value": "examplepassword"
        },
        {
          "name": "WORDPRESS_DB_NAME",
          "value": "exampledb"
        },
        {
          "name": "WORDPRESS_CACHE_HOST",
          "value": "127.0.0.1:3306"
        },

      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [
        {
          "readOnly": null,
          "containerPath": "/var/lib/wordpressit",
          "sourceVolume": "wordpress-vol"
        }
      ],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "wordpress:latest",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "testapp"
    }
  ]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    
  }
   volume {
    name      = "wordpress-vol"
    # host_path = "/ecs/service-storage"
  }
}



resource "aws_ecs_service" "test-service-wordpress-main" {
  name            = "testapp-service-wordpress-main"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.wordpress-main.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg-80.id]
    subnets          = data.aws_subnets.subnet.ids
    assign_public_ip = true
  }
    load_balancer {
    target_group_arn = module.manikanta-alb.elb-target-group-arn
    container_name   = "testapp"
    container_port   = 80
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_ecs_service.test-service-mysql]
}

data "aws_ecr_repository" "example" {
  name = "wordpress"
}
# data "aws_ecr_image" "service_image" {
#   repository_name = "wordpress"
#   image_tag = "master"
# }
# output "ecr_image" {
#   value = data.aws_ecr_image.service_image.image_tag
# }


data "external" "current_image" {
  program = ["bash", "./ecs-task-definition.sh"]
  # query = {
  #   app  = "testapp-service-wordpress-main"
  #   cluster = "wordpress-cluster"
  #   # path_root = "${jsonencode(path.root)}"
  # }
}
# output "get_new_tag" {
#   value = data.external.current_image.result["image_tag"]
# }
