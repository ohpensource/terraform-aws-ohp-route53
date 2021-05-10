locals {

  records_expanded = {
    for i, record in var.records : join("-", compact([
      lower(record.type),
      try(lower(record.name), ""),
      ])) => {
      type = record.type
      name = try(record.name, "")
      ttl  = try(record.ttl, null)
      idx  = i
    }
  }

  records_by_name = {
    for product in setproduct(local.zones, keys(local.records_expanded)) : "${product[1]}-${product[0]}" => {
      zone_id = try(aws_route53_zone.default[product[0]].id, null)
      type    = local.records_expanded[product[1]].type
      name    = local.records_expanded[product[1]].name
      ttl     = local.records_expanded[product[1]].ttl
      idx     = local.records_expanded[product[1]].idx
    }
  }

  records_by_zone_id = {
    for id, record in local.records_expanded : id => {
      zone_id = var.zone_id
      type    = record.type
      name    = record.name
      ttl     = record.ttl
      idx     = record.idx

    }
  }

  records = local.skip_zone_creation ? local.records_by_zone_id : local.records_by_name

  zones              = var.zone_name == null ? [] : try(tolist(var.zone_name), [tostring(var.zone_name)], [])
  skip_zone_creation = length(local.zones) == 0
  run_in_vpc         = length(var.vpc_ids) > 0

}   