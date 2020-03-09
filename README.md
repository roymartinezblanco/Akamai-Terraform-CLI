# Akamai-Terraform-CLI
 Akamai Terraform with WAF CLI Actication


This terraform template is very similar to https://github.com/dmcallis1/akamai-terraform-kickstart but wit the exception that it will look at how to also add domains to Akamai's WAF. 

This project is a work in progress


```terraform
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


```

## Author
Me https://roymartinez.dev/
## Licensing
I am providing code and resources in this repository to you under an open-source license. Because this is my repository, the license you receive to my code and resources is from me and not my employer (Akamai).

```
Copyright 2019 Roy Martinez

Creative Commons Attribution 4.0 International License (CC BY 4.0)

http://creativecommons.org/licenses/by/4.0/
```