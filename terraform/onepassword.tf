data "onepassword_item" "cloudflare" {
  vault = local.op_vault_name
  title = "Terraform Edit DNS"
}

