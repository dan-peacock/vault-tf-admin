output "backend" {
  value = vault_aws_secret_backend.aws.path
}

output "role" {
  value = vault_aws_secret_backend_role.admin.name
}


output "azure_backend" {
  value = vault_azure_secret_backend.azure.path
}

output "azure_role" {
  value = vault_azure_secret_backend_role.generated_role.role
}