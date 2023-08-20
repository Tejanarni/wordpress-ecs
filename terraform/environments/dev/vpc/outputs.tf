output "db_subnet_ids" {
  value       = module.vpc.db_subnet_ids
  description = "List of private subnet IDs"
}

output "app_subnet_ids" {
  value       = module.vpc.app_subnet_ids
  description = "List of private subnet IDs"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of private subnet IDs"
}