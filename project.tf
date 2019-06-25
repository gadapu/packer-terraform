
data "aws_ami" "image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["packer-linux-aws-demo**"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  owners = ["self"]
  
}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "ap-south-1"
}

resource "aws_instance" "example" {
  ami            = "${data.aws_ami.image.id}"
 #ami            = "ami-0cc96feef8c6bbff3"
  instance_type  = "t2.micro"
  key_name       = "vakratunda"
  #security_groups = ["jenkins-sg"]
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                echo "Deployed via Terraform" > /var/www/html/index.html
        EOF

  tags {
    Name = "test-instance"
  }
}
