resource "aws_route53_zone" "default" {
  for_each = var.route53_create ? toset(local.zones) : []

  name = each.value
  
  dynamic "vpc" {
    for_each = { for id in var.vpc_ids : id => id }
    #for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])
    
    content {
      vpc_id = vpc.value
    }
  }

  tags = merge(
    { Name = each.value },
    var.tags
  )

}
resource "aws_route53_record" "default" {
  for_each = var.route53_create ? local.records : {}

  zone_id = each.value.zone_id
  type    = each.value.type
  name    = each.value.name
  ttl     = each.value.ttl == null ? var.default_ttl : each.value.ttl
  records = var.records[each.value.idx].records
}