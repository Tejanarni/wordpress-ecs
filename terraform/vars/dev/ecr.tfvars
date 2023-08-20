repositories = {
  "nginx" = {
    image_tag_mutability  = "IMMUTABLE"
    scan_on_push          = true
    expiration_after_days = 7
    environment           = "dev"
    tags = {
      Project     = "ECRDemo"
      Owner       = "anotherbuginthecode"
      Purpose     = "Reverse Proxy"
      Description = "NGINX docker image"
    }
  }

  "frontend" = {
    image_tag_mutability  = "IMMUTABLE"
    scan_on_push          = true
    expiration_after_days = 3
    environment           = "dev"
    tags = {
      Project     = "ECRDemo"
      Owner       = "anotherbuginthecode"
      Purpose     = "Frontend"
      Description = "Frontend docker image using ReactJS"
    }
  }

  "backend" = {
    image_tag_mutability  = "IMMUTABLE"
    scan_on_push          = true
    environment           = "dev"
    expiration_after_days = 0 # no expiration policy set
    tags = {
      Project     = "ECRDemo"
      Owner       = "anotherbuginthecode"
      Purpose     = "Backend"
      Description = "Backend docker image using Python Flask"
    }
  }
}
