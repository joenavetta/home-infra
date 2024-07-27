data "cloudflare_zone" "this" {
  name = "cowshed.cc"
}

resource "cloudflare_record" "server_a" {
  for_each = local.server_ips

  zone_id = data.cloudflare_zone.this.id
  name    = each.key
  value   = each.value
  type    = "A"
  proxied = false
}
