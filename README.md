# terraform
create two instance  and a load balancer aws and see the dns as the output when the code is applied 

# Provider Configuration
provider "aws": Configures the AWS provider with your AWS credentials and the region where resources will be created.
access_key: Your AWS access key.
secret_key: Your AWS secret key.
region: The AWS region where resources will be deployed (in this case, ap-south-1).

# EC2 Instance
resource "aws_instance" "instance1": Defines an EC2 instance.
ami: The Amazon Machine Image (AMI) ID to use for the instance.
instance_type: The type of instance to launch (t2.micro).
key_name: The name of the key pair to use for SSH access.
user_data: A shell script that runs on instance launch to install Apache, start the service, and create a custom index.html.
tags: Metadata for the instance, in this case, naming it "instance1".
same for the voth the instances: instance1 and instance2

# Security Group
resource "aws_security_group" "allow_http": Defines a security group to allow HTTP traffic.
name_prefix: Prefix for the security group name.
ingress: Rules for incoming traffic.
from_port: Starting port (80 for HTTP).
to_port: Ending port (80 for HTTP).
protocol: Protocol type (TCP).
cidr_blocks: Allowed IP ranges (0.0.0.0/0 allows all IPs).
egress: Rules for outgoing traffic.
from_port: Starting port (0).
to_port: Ending port (0).
protocol: Protocol type (-1 means all protocols).
cidr_blocks: Allowed IP ranges (0.0.0.0/0 allows all IPs).

# Load Balancer
resource "aws_lb" "web_lb": Defines an application load balancer.
name: Name of the load balancer.
internal: Specifies if the load balancer is internal (false for public).
load_balancer_type: Type of load balancer (application for ALB).
security_groups: Security groups associated with the load balancer.
subnets: Subnets in which the load balancer will be deployed.

# Target Group
resource "aws_lb_target_group" "web_tg": Defines a target group for the load balancer.
name: Name of the target group.
port: Port on which the targets are listening (80 for HTTP).
protocol: Protocol used by the targets (HTTP).
vpc_id: The VPC ID where the target group will be deployed

# Load Balancer Listner
resource "aws_lb_listener" "web_listener": Defines a listener for the load balancer.
load_balancer_arn: ARN of the load balancer.
port: Port for incoming traffic (80 for HTTP).
protocol: Protocol for incoming traffic (HTTP).
default_action: Default action when traffic is received.
type: Type of action (forward traffic).
target_group_arn: ARN of the target group to forward traffic to.

# Target Group Attachments
resource "aws_lb_target_group_attachment": Attaches EC2 instances to the target group.
target_group_arn: ARN of the target group.
target_id: ID of the instance to attach.
port: Port on which the instance listens (80 for HTTP).

# Output
output "lb_dns_name": Outputs the DNS name of the load balancer, which can be used to access the application.
