variable "bucket_name" {
    type        = string
    description = "The name of the S3 bucket"
}

variable "versioning" {
    type        = bool
    description = "Versioning option it could be either true or false"
}

variable "block_public_acls" {
    type        = bool
    description = "this option it could be either true or false"
}

variable "block_public_policy" {
    type        = bool
    description = "this option it could be either true or false"
}

variable "ignore_public_acls" {
    type        = bool
    description = "this option it could be either true or false"
}

variable "restrict_public_buckets" {
    type        = bool
    description = "this option it could be either true or false"
}



