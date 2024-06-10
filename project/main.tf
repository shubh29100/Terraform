# provider "aws" {
#   region     = "us-east-1"
#   access_key = "AKIAUS4Z3N6EBNFYMS6Q"
#   secret_key = "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"

# }
# resource "aws_instance" "ec2" {
#   ami             = "ami-02498a4936b98c931"
#   key_name        = "demokey"
#   instance_type   = "t2.micro"
#   security_group = "sg-050bc46a534c9714f"

# }
provider "aws" {
  region = "us-east-1"
  # It's better to use environment variables for access keys
   access_key = "AKIAUS4Z3N6EBNFYMS6Q"
   secret_key = "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"
}

resource "aws_instance" "ec2" {
  ami             = "ami-02498a4936b98c931"
  key_name        = "demokey"
  instance_type   = "t2.micro"
  vpc_security_group_ids = ["sg-050bc46a534c9714f"]

  tags = {
    Name = "DemoInstance"
  }
}
