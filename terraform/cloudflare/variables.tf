variable "domain_name" {
  description = "The Cloudflare-managed domain name."
  type        = string
  default     = "meggumi.com"
}

variable "github_pages_challenge_token" {
  description = "TXT value used by GitHub Pages to verify the custom domain."
  type        = string
  default     = "3484c9b0d9e5186b00f1b72f31d7df"
}
