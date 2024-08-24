data "cloudflare_zone" "primary" {
  name = "cowshed.cc"
}

resource "cloudflare_record" "server_a" {
  for_each = local.dns.a_records

  zone_id = data.cloudflare_zone.primary.id
  name    = each.key
  value   = each.value
  type    = "A"
  proxied = false
}
