module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstaion"

 instance_type = "t2.micro"
 ami = "ami-0b4f379183e5706b9"
 #ami = data.aws_ami.centos8a.id
 # key_name               = "user1"
 # monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_eksctl.id]
  subnet_id              = "subnet-0c89d14b89ba994c2"
  user_data = file("docker.sh")
   tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_eksctl" {
  name        = "allow_eksctl"
  description = "created for eksctl"
  #vpc_id      = "vpc-0956976ba12f6fc23"
  tags = {
    Name = "allow_tls"
  }

  ingress {
    description = "all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

data "aws_ami" "centos8"{
    owners = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}