provider "vault" {
  address = var.vault_address
  token = var.vault_token
}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  path       = "${var.name}-path"

  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}

resource "vault_aws_secret_backend_role" "admin" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "${var.name}-role"
  credential_type = "iam_user"

  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:*", "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# resource "vault_azure_secret_backend" "azure" {
#   use_microsoft_graph_api = true
#   subscription_id         = var.azure_subscription_id
#   tenant_id               = var.azure_tenant_id
#   client_id               = var.azure_client_id
#   client_secret           = var.azure_client_secret
#   environment             = "AzurePublicCloud"
# }

# resource "vault_azure_secret_backend_role" "generated_role" {
#   backend                     = vault_azure_secret_backend.azure.path
#   role                        = "generated_role"
#   ttl                         = 300
#   max_ttl                     = 600

#   azure_roles {
#     role_name = "Contributor"
#     scope =  "/subscriptions/${var.azure_subscription_id}"
#   }
# }