resource "aws_route53_zone" "main" {
    name = "sanchit.com"
  
}

resource "aws_route53_record" "sanchit_record" {
    zone_id = aws_route53_zone.main.zone_id
    name = "sanchit.com"
    type = "A"

    alias {
      name = aws_lb.app_lb.dns_name
      zone_id = aws_lb.app_lb.zone_id
      evaluate_target_health = true
    }  
}

# A record for subdomain (www.sanchit.com)
resource "aws_route53_record" "www_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "mytf.sanchit.com"
  type    = "A"

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}