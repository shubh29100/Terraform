provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}
resource "aws_instance" "ec2" {
  count         = 4
  ami           = "ami-00beae93a2d981137"
  key_name      = "demokey"
  instance_type = "t2.micro"

}