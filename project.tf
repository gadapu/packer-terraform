
data "aws_ami" "image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["packer-linux-aws-demo*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  owners = ["self"]
  
}


provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami            = "${data.aws_ami.image.id}"
 #ami            = "ami-0cc96feef8c6bbff3"
  instance_type  = "t2.micro"
  key_name       = "vakratunda"
  security_groups = ["jenkins-sg"]
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                mkdir app
                chmod 777 app
                cd app
                git clone -b devlop https://github.com/chabhilashraju/tutor.git
                chmod 777 tutor
                cd tutor
                npm install
                export PATH=$PATH:/root/.npm-global/bin
                service nginx restart
                ng serve --host=0.0.0.0 --disable-host-check
        EOF

  tags {
    Name = "test-instance"
  }
}
