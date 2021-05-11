# Terraform Module Template

## Maintainer

* Platform Services

## Author

* Anthony Bartle

## Version

Current version: v1.0.0

## Description

The abilty to create public or private zones and create records in them or in an existing zone in Route53 via TerraForm

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
  
## Prerequites

## Optional

## Documentation

[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)
