output "zone_id" {
  description = "Cloudflare zone ID resolved from the domain name."
  value       = data.cloudflare_zone.this.id
}

output "name_servers" {
  description = "Cloudflare authoritative name servers."
  value       = data.cloudflare_zone.this.name_servers
}
