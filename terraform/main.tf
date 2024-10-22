provider aws {
  region  = var.aws_region
  version = "~> 2.68"
}

resource "aws_s3_bucket" "redirect" {
  bucket = var.domain-name
  acl    = "public-read"

  website {
    redirect_all_requests_to = "https://www.${var.domain-name}"
  }
}

resource "aws_route53_record" "redirect" {
  zone_id = var.hostedzone_id
  name    = var.domain-name
  type    = "A"

  alias {
    name                   = aws_s3_bucket.redirect.website_domain
    zone_id                = aws_s3_bucket.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website" {
  zone_id = var.hostedzone_id
  name    = "www.${var.domain-name}"
  type    = "CNAME"
  ttl     = 86400

  records = [
    var.destination,
  ]
}
