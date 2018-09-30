output "Instance public IP" {
  value = "${aws_instance.myweb.public_dns}"
}