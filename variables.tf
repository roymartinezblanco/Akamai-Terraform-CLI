/*
  Provider Variables 
*/
variable "product_id" {
  # 'prd_SPM' = Ion Premier product code
  type = string
  default = "prd_SPM"
}

variable "hostname" {
  # Customer Facing DNS record.
  type = string
  default = "myhostname.com"

}

variable "PM_JSON_format" {
  # Identifies the rule format currently assigned to the property version’s rule tree.
  # https://developer.akamai.com/api/core_features/property_manager/v1.html
  type = string
  default = "v2018-02-27"
}
variable edgehostname {
  # EdgeHostmame to be used for hostname matching
  type = string
  default = "mydgehostname.test.edgekey.net"
}

variable "wafid" {
  #Number of the WAF configuration
  type = number
  default = 12345
}

variable "security" {
  # Name of EdgeRC Section with WAF access.
  type = string
  default = "sec"
}

variable "enrollment_id" {
  # The enrollment ID as defined in CPS
  default = 1234
}

variable "origin" { 
  # DNS Record to be used to fetch content.
  default = "www.example.com"
}