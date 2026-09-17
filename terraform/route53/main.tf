data "cloudflare_zone" "this" {
  filter = {
    name = var.domain_name
  }
}

locals {
  github_pages_ipv4 = toset([
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ])
}

resource "cloudflare_dns_record" "github_pages_a" {
  for_each = local.github_pages_ipv4

  zone_id = data.cloudflare_zone.this.id
  name    = var.domain_name
  type    = "A"
  ttl     = 1
  content = each.value
  proxied = false
}

resource "cloudflare_dns_record" "www_cname" {
  zone_id = data.cloudflare_zone.this.id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  content = "gumigumih.github.io"
  proxied = false
}

resource "cloudflare_dns_record" "me_cname" {
  zone_id = data.cloudflare_zone.this.id
  name    = "me.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  content = "gumigumih.github.io"
  proxied = false
}

resource "cloudflare_dns_record" "portfolio_cname" {
  zone_id = data.cloudflare_zone.this.id
  name    = "portfolio.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  content = "gumigumih-portfolio-c2h.pages.dev"
  proxied = false
}

resource "cloudflare_dns_record" "google_mx" {
  zone_id  = data.cloudflare_zone.this.id
  name     = var.domain_name
  type     = "MX"
  ttl      = 1
  content  = "smtp.google.com"
  priority = 1
}

resource "cloudflare_dns_record" "google_site_verification" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 1
  content = "google-site-verification=0AT7NUWB3p532OZJLR-MwebB7oomUjyNrfV2Mor2gYw"
}

resource "cloudflare_dns_record" "github_pages_challenge" {
  zone_id = data.cloudflare_zone.this.id
  name    = "_github-pages-challenge-gumigumih.${var.domain_name}"
  type    = "TXT"
  ttl     = 1
  content = var.github_pages_challenge_token
}
