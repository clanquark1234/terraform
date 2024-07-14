# terraform
create two instance  and a load balancer aws and see the dns as the output when the code is applied 

# Provider Configuration
<b>provider "aws":</b> Configures the AWS provider with your AWS credentials and the region where resources will be created.<br>
<b>access_key:</b> Your AWS access key.<br>
<b>secret_key:</b> Your AWS secret key.<br>
<b>region:</b> The AWS region where resources will be deployed (in this case, ap-south-1).

# EC2 Instance
<b>resource "aws_instance" "instance1":</b> Defines an EC2 instance.<br>
<b>ami:</b> The Amazon Machine Image (AMI) ID to use for the instance.<br>
<b>instance_type:</b> The type of instance to launch (t2.micro).<br>
<b>key_name:</b> The name of the key pair to use for SSH access.<br>
<b>user_data:</b> A shell script that runs on instance launch to install Apache, start the service, and create a custom index.html.<br>
<b>tags:</b> Metadata for the instance, in this case, naming it "instance1".<br>
same for the voth the instances: instance1 and instance2

# Security Group
<b>resource "aws_security_group" "allow_http":</b> Defines a security group to allow HTTP traffic.<br>
<b>name_prefix:</b> Prefix for the security group name.<br>
<b>ingress:</b> Rules for incoming traffic.<br>
<b>from_port:</b> Starting port (80 for HTTP).<br>
<b>to_port:</b> Ending port (80 for HTTP).<br>
<b>protocol:</b> Protocol type (TCP).<br>
<b>cidr_blocks:</b> Allowed IP ranges (0.0.0.0/0 allows all IPs).<br>
<b>egress:</b> Rules for outgoing traffic.<br>
<b>from_port:</b> Starting port (0).<br>
<b>to_port:</b> Ending port (0).<br>
<b>protocol:</b> Protocol type (-1 means all protocols).<br>
<b>cidr_blocks:</b> Allowed IP ranges (0.0.0.0/0 allows all IPs).

# Load Balancer
<b>resource "aws_lb" "web_lb":</b> Defines an application load balancer.<br>
<b>name:</b> Name of the load balancer.<br>
<b>internal:</b> Specifies if the load balancer is internal (false for public).<br>
<b>load_balancer_type:</b> Type of load balancer (application for ALB).<br>
<b>security_groups:</b> Security groups associated with the load balancer.<br>
<b>subnets:</b> Subnets in which the load balancer will be deployed.<br>

# Target Group
<b>resource "aws_lb_target_group" "web_tg":</b> Defines a target group for the load balancer.<br>
<b>name:</b> Name of the target group.<br>
<b>port:</b> Port on which the targets are listening (80 for HTTP).<br>
<b>protocol:</b> Protocol used by the targets (HTTP).<br>
<b>vpc_id:</b> The VPC ID where the target group will be deployed<br>

# Load Balancer Listner
<b>resource "aws_lb_listener" "web_listener":</b> Defines a listener for the load balancer.<br>
<b>load_balancer_arn:</b> ARN of the load balancer.<br>
<b>port:</b> Port for incoming traffic (80 for HTTP).<br>
<b>protocol:</b> Protocol for incoming traffic (HTTP).<br>
<b>default_action:</b> Default action when traffic is received.<br>
<b>type:</b> Type of action (forward traffic).<br>
<b>target_group_arn:</b> ARN of the target group to forward traffic to.

# Target Group Attachments
<b>resource "aws_lb_target_group_attachment":</b> Attaches EC2 instances to the target group.<br>
<b>target_group_arn:</b> ARN of the target group.<br>
<b>target_id:</b> ID of the instance to attach.<br>
<b>port:</b> Port on which the instance listens (80 for HTTP).<br>

# Output
<b>output "lb_dns_name":</b> Outputs the DNS name of the load balancer, which can be used to access the application.<br>
