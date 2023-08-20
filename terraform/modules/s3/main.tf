resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Block public access configuration
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls 
  restrict_public_buckets = var.restrict_public_buckets
}

data "aws_iam_policy_document" "allow_access_from_ip" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [aws_s3_bucket.my_bucket.arn, "${aws_s3_bucket.my_bucket.arn}/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["192.168.1.0/24"]  # Replace with your desired IP range
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_ip" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_ip.json
}



