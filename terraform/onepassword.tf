data "onepassword_item" "cloudflare" {
  vault = local.one_password.vault_name
  title = "Terraform Edit DNS"
}

