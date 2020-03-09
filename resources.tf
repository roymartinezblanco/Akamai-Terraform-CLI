resource "akamai_edge_hostname" "edgehostname" {
    edge_hostname = "${var.edgehostname}"
    product  = "${var.product_id}"
    contract = "${data.akamai_contract.default.id}"
    group = "${data.akamai_group.default.id}"

    # The CPS enrollment ID which can support the edge hostname, defined above
    certificate = "${var.enrollment_id}"
    ipv4 = true
    ipv6 = false
    
}
resource "akamai_cp_code" "myCPcode" {
    product = "${var.product_id}"
    contract = "${data.akamai_contract.default.id}"
    group = "${data.akamai_group.default.id}"
    name	= "myCPcode"
}

resource "akamai_property" "myconfig" {
  
  name        = "myconfig"
  contact     = ["myemail@akamai.com"]

  cp_code     = "${akamai_cp_code.myCPcode.id}"
  contract = "${data.akamai_contract.default.id}"
  group = "${data.akamai_group.default.id}"
  product     = "${var.product_id}"
  rule_format = "${var.PM_JSON_format}"

  hostnames = {
   "${var.hostname}" = "${akamai_edge_hostname.edgehostname.edge_hostname}"
 
  }

  rules       = "${data.template_file.init.rendered}"
  is_secure = true

}

resource "akamai_property_activation" "myconfig-stage" {
        property = "${akamai_property.myconfig.id}"
        version = "${akamai_property.myconfig.version}"
        contact = ["myemail@akamai.com"]
        network = "STAGING"
        activate = true
}

resource "akamai_property_activation" "myconfig-prod" {
        property = "${akamai_property.myconfig.id}"
        version = "${akamai_property.myconfig.version}"
        contact = ["myemail@akamai.com"]
        network = "PRODUCTION"
        activate = false
}

resource "null_resource" "web_application_firewall" {

  provisioner "local-exec" {
        command = "akamai appsec clone --version STAGING --config ${var.wafid} --section ${var.security}"
  }
  provisioner "local-exec" {
        command = "akamai appsec add-hostname ${var.hostname} --config ${var.wafid} --section ${var.security}"
  }
  provisioner "local-exec" {
        command = "akamai appsec activate --network STAGING --notify=myemail @akamai.com --config ${var.wafid}  --section ${var.security}"
  }
}
