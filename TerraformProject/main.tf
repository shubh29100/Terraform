
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUS4Z3N6EBNFYMS6Q"  #Enter your access key and secret access key
  secret_key = "PUskb3BW1snWstcxk1q6bFNoX7pCrft5vbDZZpv0"
}

resource "aws_instance" "my_project_instance" {
  ami           = "ami-07bdefe31ad285925"  #Enter your custom ami id
  instance_type = "t2.micro"

  # Specify a key pair if you need SSH access
  key_name = "instancekey"

  # Security group to allow HTTP, HTTPS, and MySQL access
  vpc_security_group_ids = [aws_security_group.my_project_sg.id]

  # Provisioners to start the project
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 700 /home/ec2-user/apache-tomcat-8.5.100/bin/catalina.sh",
      "sudo /home/ec2-user/apache-tomcat-8.5.100/bin/catalina.sh start",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/Admin/Downloads/demokey.pem")  #Enter path to your aws key file
      host        = self.public_ip
    }
  }

  tags = {
    Name = "MyProjectInstance"
  }
}

resource "aws_security_group" "my_project_sg" {
  name        = "my_project_sg"
  description = "Allow HTTP, HTTPS, and MySQL traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# provider "aws" {
#   region     = "us-east-1"
#   access_key = "AKIAUS4Z3N6EBNFYMS6Q"  # Enter your access key
#   secret_key = "PUskb3BW1snWstcxk1q6bFNoX7pCrft5vbDZZpv0"       # Enter your secret access key
# }

# resource "aws_security_group" "my_project_sg" {
#   name        = "my_project_sg"
#   description = "Allow HTTP, HTTPS, and MySQL traffic"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_instance" "my_project_instance" {
#   ami           = "ami-0bbb9d0df6ad572f4"  # Enter your custom AMI ID
#   instance_type = "t2.micro"

#   # Specify a key pair if you need SSH access
#   key_name = "demokey"

#   # Security group to allow HTTP, HTTPS, and MySQL access
#   vpc_security_group_ids = [aws_security_group.my_project_sg.id]

#   # Provisioners to start the project
#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum update -y",
#       "sudo yum install -y wget tar",
#       "wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100.tar.gz -P /tmp",
#       "sudo mkdir -p /opt/tomcat",
#       "sudo tar xf /tmp/apache-tomcat-8.5.100.tar.gz -C /opt/tomcat",
#       "sudo ln -sfn /opt/tomcat/apache-tomcat-8.5.100 /opt/tomcat/latest",
#       "echo 'Contents of /opt/tomcat:'",
#       "ls -l /opt/tomcat",
#       "echo 'Contents of /opt/tomcat/latest/bin:'",
#       "ls -l /opt/tomcat/latest/bin",
#       "if [ -d /opt/tomcat/latest/bin ]; then sudo chmod +x /opt/tomcat/latest/bin/*.sh; fi",
#       "if [ -f /opt/tomcat/latest/bin/startup.sh ]; then sudo /opt/tomcat/latest/bin/startup.sh; fi",
#       "sudo systemctl start nginx",
#       "sudo systemctl enable nginx"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file("C:/Users/Admin/Downloads/demokey.pem")  # Enter path to your AWS key file
#       host        = self.public_ip
#     }
#   }

#   tags = {
#     Name = "MyProjectInstance"
#   }
# }
