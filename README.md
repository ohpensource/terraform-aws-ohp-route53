## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | (Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set. | `number` | `3600` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of records to create in the Hosted Zone. | `any` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_route53_create"></a> [route53\_create](#input\_route53\_create) | (Optional) Whether to create a zone within the module or not. Default is false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to apply to all created resources that support tags. | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | (Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation\_set\_id. | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) A zone ID to create the records in | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | (Required) The name of the hosted zone. To create multiple zones at once, pass a list of names ["zone1", "zone2"]. | `any` | `null` | no |

## Outputs

No outputs.

## Usage (example 1 - public zone with records)

        module "route53_test" {
        route53_create        = true
        source                = "../route53"
        tags = {
            ManagedBy = "Platform Services"
            }

        zone_name = "testzone.com"      # Single: zone_name = "example.com" or Multiple: zone_name = ["example.com", "example.co.uk"]

        records = [
        {
            name = "a.testzone.com"
            type = "A"
            ttl  = "900"
            records = [
                "10.192.168.1",
                ]
        },
        {
            name = "www"
            type = "CNAME"
            ttl  = "5"
            records = [
                "a.testzone.com",
                ]
        }
     ]
    }

    (example 2 - private zone with records) 

    module "route53_test" {
        route53_create        = true
        source                = "../route53"
        tags = {
                ManagedBy = "Platform Services"
            }

        vpc_ids               = [var.vpc_id]
        
        zone_name = "testzone.com"      # Single: zone_name = "example.com" or Multiple: zone_name = ["example.com", "example.co.uk"]

        records = [
        {
        name = "a.testzone.com"
        type = "A"
        ttl  = "900"
        records = [
            "10.192.168.1",
            ]
        },
        {
        name = "www"
        type = "CNAME"
        ttl  = "5"
        records = [
            "a.testzone.com",
            ]
        }
    ]
}

    (example 3 - add records to existing private zone) 

    module "route53_test" {
        route53_create        = true
        source                = "../route53"
        tags = {
                ManagedBy = "Platform Services"
            }

        vpc_ids               = [var.vpc_id]
        
        zone_id = "testzone.com" 

        records = [
        {
        name = "a.testzone.com"
        type = "A"
        ttl  = "900"
        records = [
            "10.192.168.1",
            ]
        },
        {
        name = "www"
        type = "CNAME"
        ttl  = "5"
        records = [
            "a.testzone.com",
            ]
        }
    ]
}