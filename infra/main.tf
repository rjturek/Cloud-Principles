# --- since terraform can create infrastructure in 
# --- multiple providers, we need to tell it we are
# --- using AWS.
provider "aws" {
    region = "us-east-1"
}
 

# --- generate a Web Server
resource "aws_instance" "webserver" {
    instance_type = "t2.micro"
    ami = "ami-75f8e245"
    key_name = "webserver1_aws"
    associate_public_ip_address = true
}

# --- generate a database server
resource "aws_instance" "dbserver" {
    instance_type = "t2.micro"
    ami = "ami-75f8e245"
    key_name = "dbserver1_aws"
}

# --- generate the app server
resource "aws_instance" "appserver" {
    instance_type = "t2.micro"
    ami = "ami-75f8e245"
    key_name = "appserver1_aws"
}