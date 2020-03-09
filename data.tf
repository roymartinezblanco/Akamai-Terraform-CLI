
data "akamai_contract" "default" {
  group = ""
}


data "akamai_group" "default" {
  name = ""
}


data "template_file" "init" {
    template = "${file("${path.module}/template.json")}"
}

