# AWS Medical Examination Using Terraform

 Let's start and set up a 2-tier architecture using the following AWS services:

- **Region**
- **VPC**
- **Availability Zone**
- **Public Subnet**
- **Private Subnet**
- **Route Table**
- **Internet Gateway**
- **EC2 Instance**
- **Nat Gateway**
- **Elastic IP Address**

**Architecture**

![Complete 2-Tier AWS Architecture](Final-2-tier.png)

Complete 2-Tier AWS Architecture

**Provider**

![Provider with AWS Region Setup in the architecture](provider.png)

Provider with AWS Region Setup in the architecture

**VPC**

![AWS VCP Configuration in the architecture](vpc.png)

AWS VCP Configuration in the architecture

**Public Subnet**

![Public Subnet in Availability Zone ap-southeast-1a in the architecture](public-subnet.png)

Public Subnet in Availability Zone ap-southeast-1a in the architecture

**Private Subnet**

![Private Subnet in zone ap-southeast-1a in the architecture](private_subnet.png)

Private Subnet in zone ap-southeast-1a in the architecture

**Route Table**

![Setup route table in the architecture](route_table.png)

Setup route table in the architecture

**Route Table Association**

![Associate subnets with the route table in the architecture](routetable_association.png)

Associate subnets with the route table in the architecture

**Internet Gateway**

![Setup Internet Gateway in the architecture](internet_gateway.png)

Setup Internet Gateway in the architecture

**Security Group**

![Setup Bastion Host Security Group in the architecture](public_ec2_sg.png)

Setup Bastion Host Security Group in the architecture

**Security Group for private host**

![Setup Security Group for private server in the architecture](private_ec2_sg.png)

Setup Security Group for private server in the architecture

**Bastion or Jump Server**

![Bastion or Jump server in public subnet](bastion_host.png)

Bastion or Jump server in public subnet

**Private machine**

![EC2 instance in private subnet](private_instance.png)

EC2 instance in private subnet

**Nat Gateway Setup**

![Nat Gateway Setup](nat_gateway.png)

Setup Nat Gateway

**Elastic IP Address**

![EC2 instance in private subnet](eip.png)

Elastic IP Address for Nat Gateway
