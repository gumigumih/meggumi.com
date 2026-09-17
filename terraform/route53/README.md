# meggumi.com のCloudflare DNS

Cloudflare Registrarへ移管した `meggumi.com` のDNSレコードをTerraformで管理する設定です。

TerraformはCloudflare APIを使用します。APIトークンはファイルに保存せず、環境変数で渡してください。

```sh
cd terraform/route53
cp terraform.tfvars.example terraform.tfvars
export CLOUDFLARE_API_TOKEN="<Cloudflare API token>"
terraform init
```

APIトークンには、対象ゾーンの `DNS Read` と `DNS Write` 権限が必要です。`terraform plan` は既存レコードをTerraformへ取り込む前に実行しないでください。未取り込みのレコードを新規作成しようとして、重複エラーになる可能性があります。

## 既存レコードの取り込み

Cloudflare APIまたはダッシュボードでゾーンIDと各DNSレコードのIDを確認し、次の形式で取り込みます。

```sh
terraform import 'cloudflare_dns_record.github_pages_a["185.199.108.153"]' ZONE_ID/RECORD_ID
terraform import 'cloudflare_dns_record.github_pages_a["185.199.109.153"]' ZONE_ID/RECORD_ID
terraform import 'cloudflare_dns_record.github_pages_a["185.199.110.153"]' ZONE_ID/RECORD_ID
terraform import 'cloudflare_dns_record.github_pages_a["185.199.111.153"]' ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.www_cname ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.me_cname ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.portfolio_cname ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.google_mx ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.google_site_verification ZONE_ID/RECORD_ID
terraform import cloudflare_dns_record.github_pages_challenge ZONE_ID/RECORD_ID
terraform plan
```

`plan` でTTL、値、プロキシ設定が意図どおりであることを確認してから `apply` します。この定義には、GitHub PagesのA/CNAME、GoogleメールのMX、Google Search ConsoleのTXT、GitHub Pages確認用TXTを含めています。

CloudflareのDNSレコードはGitHub Pagesとの互換性を優先してDNSのみ（プロキシなし）にしています。
