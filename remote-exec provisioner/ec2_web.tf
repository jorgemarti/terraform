

resource "aws_instance" "myweb" {
   ami = "ami-0bdb1d6c15a40392c"
   instance_type = "t2.micro"
   security_groups = ["${aws_security_group.mysg.name}"]
   key_name = "deployer-key"

   tags {
      Name = "web-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install epel -y",
      "sudo yum -y install nginx git",
      "sudo mkdir -p /var/www/html",
      "sudo sed -i -e 's/\\/usr\\/share\\/nginx\\/html/\\/var\\/www\\/html/g' /etc/nginx/nginx.conf",
      "sudo git clone https://github.com/Microsoft/project-html-website.git /var/www/html",
      "sudo systemctl start nginx && sudo systemctl enable nginx"
    ]
    connection {
      type = "ssh"
      user = "ec2-user"
    }
  }

}
