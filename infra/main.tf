variable DEFAULT_REGION_NAME {}
variable AWS_ACCESS_KEY_ID  {}
variable AWS_SECRET_ACCESS_KEY {}

# --- since terraform can create infrastructure in 
# --- multiple providers, we need to tell it we are
# --- using AWS.
provider "aws" {
    region = "${var.DEFAULT_REGION_NAME}"
    access_key = "${var.AWS_ACCESS_KEY_ID}"
    secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
}
 

# --- generate a Web Server
resource "aws_instance" "webserver" {
    instance_type = "t2.micro"
    ami = "ami-23f5ed49"
    key_name = "webserver1_aws"
    associate_public_ip_address = true
    provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start"
    ]
  }
}

# --- generate a database server
resource "aws_instance" "dbserver" {
    instance_type = "t2.micro"
    ami = "ami-23f5ed49"
    key_name = "dbserver1_aws"
    provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install mysql-server",
      "sudo service mysqld start"
    ]
  }
}

# --- generate the app server
resource "aws_instance" "appserver" {
    instance_type = "t2.micro"
    ami = "ami-23f5ed49"
    key_name = "appserver1_aws"
    provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install tomcat8",
      "sudo service tomcat8 start"
    ]
  }
}