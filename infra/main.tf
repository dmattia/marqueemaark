provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

locals {
  domain = "marqueemark.org"
}

/** Create the S3 bucket with CloudFront distribution necessary to host the site */
module "cloudfront-s3-cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.33.0"

  name = "marquee-mark"
  encryption_enabled = true

#   parent_zone_id = data.aws_route53_zone.zone.id
#   acm_certificate_arn = module.acm.this_acm_certificate_arn
#   aliases = [local.domain]
  ipv6_enabled = true

  // Caching Settings
  default_ttl = 300
  compress = true

  # Website settings
  website_enabled = true
  index_document  = "index.html"
  error_document  = "index.html"
}

# /** Make an SSL Certificate */
# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> v2.0"

#   domain_name  = local.domain
#   zone_id      = data.aws_route53_zone.zone.id
# }

# /** Lookup our hosted zone for our domain */
# data "aws_route53_zone" "zone" {
#   name = local.domain
# }