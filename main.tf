provider "aws" {
    access_key = "Add Your Key "
    secret_key = "Add Your Key"
    region = "ap-south-1"
  
}
resource "aws_instance" "instance1"{
    ami = "ami-xxxxxxxxxx" #Add Your ami
    instance_type = "t2.micro"
    key_name = "Add key"
    user_data = <<-EOF
                #!/bin/bash
                apt update
                apt install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<html><body><h1>instance1</h1></body></html>" > /var/www/html/index.html
                EOF

    tags = {
        "Name" = "instance1"
    }
}
resource "aws_instance" "instance2"{
    ami = "ami-xxxxxxxxxxxxx" #Add Your ami
    instance_type = "t2.micro"
    key_name = "mykey"
     user_data = <<-EOF
                #!/bin/bash
                apt update
                apt install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<html><body><h1>instance2</h1></body></html>" > /var/www/html/index.html
                EOF
    tags = {
        "Name" = "instance2"
    }
}
resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http"

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = ["subnet-xxxxxxxx", "subnet-xxxxxxxxxx"] # Replace with your subnet IDs
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-xxxxxxxxxxx" # Replace with your VPC ID
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "instance1" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance2" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.instance2.id
  port             = 80
}

output "lb_dns_name" {
  value = aws_lb.web_lb.dns_name
}
