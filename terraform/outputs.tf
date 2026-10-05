output "environment" {
  description = "Current deployment environment"
  value       = var.environment
}

output "frontend_url" {
  description = "Frontend application URL"
  value       = "http://localhost:${var.frontend_port}"
}

output "backend_url" {
  description = "Backend API URL"
  value       = "http://localhost:${var.backend_port}"
}