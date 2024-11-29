# Terraform AWS Infrastructure with Dockerized Nginx

## Project Overview

This project automates the creation of a scalable AWS infrastructure using **Terraform**. The setup includes a Virtual Private Cloud (VPC), subnets, NAT Gateway, and an Application Load Balancer (ALB). It deploys an EC2 instance in private subnets running a **Dockerized Nginx application** that serves HTTP traffic.

---

## Features

- **Infrastructure as Code (IaC)**:
  - Automates AWS resource provisioning using Terraform.
  - Organized modular design for scalability and maintainability.

- **AWS Services**:
  - **VPC**: Custom virtual private network with public and private subnets.
  - **NAT Gateway**: Provides internet access to resources in private subnets.
  - **Application Load Balancer (ALB)**: Distributes incoming traffic to EC2 instances.
  - **EC2 Instances**: Hosts the Nginx application in Docker.

- **Dockerized Application**:
  - Nginx serves a simple web page ("yo this is nginx").

- **Security**:
  - Security Groups configured to allow only necessary traffic.
  - Private subnets protect the EC2 instances from direct internet exposure.

---

## Architecture Diagram

The architecture consists of the following:
1. A **VPC** with public and private subnets.
2. An **Internet Gateway** for public subnet internet access.
3. A **NAT Gateway** in public subnets for private subnet internet access.
4. An **Application Load Balancer** in public subnets to distribute traffic to private EC2 instances.
5. **EC2 instances** running Dockerized Nginx in private subnets.

---

