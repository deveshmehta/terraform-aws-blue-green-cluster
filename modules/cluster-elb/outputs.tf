output "dns_name" {
  value = "${aws_elb.elb.*.dns_name}"
}

output "zone_id" {
  value = "${aws_elb.elb.*.zone_id}"
}

output "id" {
  value = "${aws_elb.elb.*.id}"
}

output "name" {
  value = "${aws_elb.elb.*.name}"
}

output "arn" {
  value = "${aws_elb.elb.*.arn}"
}

output "security_group_id" {
  value = "${module.elb_security_group.this_security_group_id}"
}