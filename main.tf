provider "aws" {
  region     = "us-east-1"
}
# ==============================================================================
# Create VPC
# ==============================================================================
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "my_VPC"
  }
}
# ==============================================================================
# Create subnet 1
# ==============================================================================
resource "aws_subnet" "Subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet_1"
  }
}
# ==============================================================================
# Create an EC2 in subnet 1
# ==============================================================================
resource "aws_instance" "VM_1" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.Subnet_1.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform_First"
  }
}
# ==============================================================================
# Create subnet 2
# ==============================================================================
resource "aws_subnet" "Subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet_2"
  }
}
# ==============================================================================
# Create an EC2 in subnet 2
# ==============================================================================
resource "aws_instance" "VM_2" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.Subnet_2.id
  availability_zone = "us-east-1b"

  tags = {
    Name = "Terraform_Second"
  }
}
# ==============================================================================
# Create dev Group
# ==============================================================================
resource "aws_iam_group" "developers" {
  name = "developers"
}
# ==============================================================================
# Create dev User
# ==============================================================================
resource "aws_iam_user" "dev_1" {
  name = "David_Love"
  path = "/engineering/"

  tags = {
    tag-key = "David Love"
  }
}
# ==============================================================================
# Add users to dev Group
# ==============================================================================
resource "aws_iam_user_group_membership" "dev_team_membership" {
  user = aws_iam_user.dev_1.name # "WHO am I adding?"

  groups = [
    aws_iam_group.developers.name, # "WHERE am I putting them?"
  ]
}
# ==============================================================================
# Attach policy to dev Group
# ==============================================================================
resource "aws_iam_group_policy_attachment" "dev_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDevOpsGuruFullAccess"
}