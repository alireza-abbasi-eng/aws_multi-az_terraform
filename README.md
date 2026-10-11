# AWS Multi-AZ Network Architecture with Terraform

An enterprise-grade, highly available Amazon Web Services (AWS) Virtual Private Cloud (VPC) provisioned with Infrastructure as Code (IaC) using Terraform. 

This repository establishes the foundational networking backbone designed to host fault-tolerant, multi-tier cloud applications across multiple Availability Zones.

---

## Architecture Overview
## Architecture Overview

### Subnet Allocation & Networking Design

| Subnet Name | Type | CIDR Block | Availability Zone | Route Target |
| :--- | :--- | :--- | :--- | :--- |
| `public-subnet-1` | Public | `10.0.1.0/24` | `us-east-1a` | Internet Gateway (`igw`) |
| `public-subnet-2` | Public | `10.0.2.0/24` | `us-east-1b` | Internet Gateway (`igw`) |
| `private-subnet-1` | Private | `10.0.3.0/24` | `us-east-1a` | Local VPC Only |
| `private-subnet-2` | Private | `10.0.4.0/24` | `us-east-1b` | Local VPC Only |

- **VPC CIDR:** `10.0.0.0/16`
- **Internet Gateway:** Attached to VPC for public egress/ingress


### Key Components:
- **Custom VPC:** IPv4 CIDR block `10.0.0.0/16` with DNS hostnames and DNS resolution enabled.
- **Multi-AZ Redundancy:** Resources provisioned across 2 Availability Zones (`us-east-1a` and `us-east-1b`) for disaster recovery and high availability.
- **Public Subnets (2x):** Configured with auto-assign public IPv4 for edge resources (e.g., Load Balancers, Bastion hosts).
- **Private Subnets (2x):** Isolated subnets strictly reserved for internal compute workloads and secure database tiers.
- **Internet Gateway (IGW):** Attached to the VPC to enable ingress/egress connectivity for public subnets.
- **Explicit Route Tables:** 
  - Public route table routing `0.0.0.0/0` outbound traffic through the Internet Gateway.
  - Independent private route table keeping internal traffic bounded within the local VPC CIDR.



---
## Deployment Instructions

### Prerequisites
- AWS CLI configured with appropriate IAM permissions
- Terraform installed (>= v1.5.0)

### Quickstart
1. **Clone the repository:**
   ```bash
   git clone https://github.com/alireza-abbasi-eng/aws_multi-az_vpc_terraform.git
   cd aws_multi-az_vpc_terraform
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review planned resources:**
   ```bash
   terraform plan
   ```

4. **Deploy the infrastructure:**
   ```bash
   terraform apply
   ```

5. **Clean up resources (destroy):**
   ```bash
   terraform destroy
   ```

---

## Author

- **Alireza Abbasi** - [GitHub Profile](https://github.com/alireza-abbasi-eng)