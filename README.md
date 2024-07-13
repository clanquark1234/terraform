# terraform
create two instance  and a load balancer aws and see the dns as the output when the code is applied 

# Provider Configuration
provider "aws": Configures the AWS provider with your AWS credentials and the region where resources will be created.<br>
access_key: Your AWS access key.<br>
secret_key: Your AWS secret key.<br>
region: The AWS region where resources will be deployed (in this case, ap-south-1).

# EC2 Instance
resource "aws_instance" "instance1": Defines an EC2 instance.<br>
ami: The Amazon Machine Image (AMI) ID to use for the instance.<br>
instance_type: The type of instance to launch (t2.micro).<br>
key_name: The name of the key pair to use for SSH access.<br>
user_data: A shell script that runs on instance launch to install Apache, start the service, and create a custom index.html.<br>
tags: Metadata for the instance, in this case, naming it "instance1".<br>
same for the voth the instances: instance1 and instance2

# Security Group
resource "aws_security_group" "allow_http": Defines a security group to allow HTTP traffic.<br>
name_prefix: Prefix for the security group name.<br>
ingress: Rules for incoming traffic.<br>
from_port: Starting port (80 for HTTP).<br>
to_port: Ending port (80 for HTTP).<br>
protocol: Protocol type (TCP).<br>
cidr_blocks: Allowed IP ranges (0.0.0.0/0 allows all IPs).<br>
egress: Rules for outgoing traffic.<br>
from_port: Starting port (0).<br>
to_port: Ending port (0).<br>
protocol: Protocol type (-1 means all protocols).<br>
cidr_blocks: Allowed IP ranges (0.0.0.0/0 allows all IPs).

# Load Balancer
resource "aws_lb" "web_lb": Defines an application load balancer.<br>
name: Name of the load balancer.<br>
internal: Specifies if the load balancer is internal (false for public).<br>
load_balancer_type: Type of load balancer (application for ALB).<br>
security_groups: Security groups associated with the load balancer.<br>
subnets: Subnets in which the load balancer will be deployed.<br>

# Target Group
resource "aws_lb_target_group" "web_tg": Defines a target group for the load balancer.
name: Name of the target group.
port: Port on which the targets are listening (80 for HTTP).
protocol: Protocol used by the targets (HTTP).
vpc_id: The VPC ID where the target group will be deployed

# Load Balancer Listner
resource "aws_lb_listener" "web_listener": Defines a listener for the load balancer.<br>
load_balancer_arn: ARN of the load balancer.<br>
port: Port for incoming traffic (80 for HTTP).<br>
protocol: Protocol for incoming traffic (HTTP).<br>
default_action: Default action when traffic is received.<br>
type: Type of action (forward traffic).<br>
target_group_arn: ARN of the target group to forward traffic to.

# Target Group Attachments
resource "aws_lb_target_group_attachment": Attaches EC2 instances to the target group.<br>
target_group_arn: ARN of the target group.<br>
target_id: ID of the instance to attach.<br>
port: Port on which the instance listens (80 for HTTP).<br>

# Output
output "lb_dns_name": Outputs the DNS name of the load balancer, which can be used to access the application.<br>
