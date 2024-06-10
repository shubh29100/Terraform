provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}
resource "aws_instance" "ec2" {
  for_each      = toset(var.aws_ami)
  ami           = each.value
  key_name      = "demokey"
  instance_type = "t2.micro"

}

variable "aws_ami" {
  type    = list(string)
  default = ["ami-00beae93a2d981137", "ami-0fe630eb857a6ec83", "ami-04b70fa74e45c3917", "ami-058bd2d568351da34"]


}
variable "aws_user_name" {
  type    = list(string)
  default = ["1", "2", "3", "4"]

}