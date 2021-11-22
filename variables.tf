variable "region" { default = "eu-west-1" }

variable "zone_name" {
  description = "(Required) The name of the hosted zone. To create multiple zones at once, pass a list of names [\"zone1\", \"zone2\"]."
  type        = any
  default     = null
}

variable "records" {
  description = "(Optional) A list of records to create in the Hosted Zone."
  type        = any
  default     = []
}

variable "default_ttl" {
  description = "(Optional) The default TTL ( Time to Live ) in seconds that will be used for all records that support the ttl parameter. Will be overwritten by the records ttl parameter if set."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "(Optional) A map of tags to apply to all created resources that support tags."
  type        = map(string)
  default     = {}
}

variable "vpc_ids" {
  description = "(Optional) A list of IDs of VPCs to associate with a private hosted zone. Conflicts with the delegation_set_id."
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "(Optional) A zone ID to create the records in"
  type        = string
  default     = null
}

variable "route53_create" {
  type        = bool
  description = "(Optional) Whether to create a zone within the module or not. Default is false."
  default     = false
}

