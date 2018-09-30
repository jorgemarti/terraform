provider "aws" {
  region     = "eu-west-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["93.176.160.174/32"]
  
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCybBxa+NoQnuHiBiyho3M0ieQB3n8ct30CRadcSffMCVrW8wEwVdMORxRCgwrv72DNmhlU7XwCKE2KG57KiD+Tg/Rt9C3au6gWhPVSxvaycf00FaxQL86p89DerApjjsiuKxIR/J2Z734VL7BfufKWzILCa8Y5hLln2xJuwyoApHJ3ZdZHOeULbQWOtXmKjH6fUlRUTn2u8Ge3BdBq1v47YtBPzLhF3bSMSZMRhmXCXLui7TRXdGjAkx3BYsLQjBVUP586bJ1cVNBCFR6GgBw/LQlR6mYEGgIHuOXdsJbSwCD62SnRg8Bc64dZUVgqV4QM5V+b4bOi88SPiwebkQSV cockemc@indiana"
}
resource "aws_instance" "web" {
  ami           = "ami-0bdb1d6c15a40392c"
  instance_type = "t2.micro"
  security_groups = [
    "${aws_security_group.allow_ssh.name}"
    ]
  key_name = "${aws_key_pair.deployer.key_name}"
tags {
  Name = "Initial Web Server"
}
}

output "Instance public IP" {
  value = "${aws_instance.web.public_dns}"
}
