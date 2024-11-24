#!/bin/bash

# Variables
VPC_CIDR="10.0.0.0/16"
SUBNET_CIDR="10.0.0.0/24"
AVAILABILITY_ZONE="us-east-1a"
VPC_NAME="ProductionVPC"
SUBNET_NAME="PublicSubnet1"
IGW_NAME="ProductionIGW"
ROUTE_TABLE_NAME="ProductionRouteTable"

# Create a new VPC (ProductionVPC)
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value='$VPC_NAME'}]' --query 'Vpc.VpcId' --output text)
echo "Created VPC with ID: $VPC_ID and Name: $VPC_NAME"

# Create a subnet in the VPC (PublicSubnet1)
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR --availability-zone $AVAILABILITY_ZONE --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value='$SUBNET_NAME'}]' --query 'Subnet.SubnetId' --output text)
echo "Created Subnet with ID: $SUBNET_ID and Name: $SUBNET_NAME"

# Create an Internet Gateway (ProductionIGW)
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
echo "Created Internet Gateway with ID: $IGW_ID"

# Attach the Internet Gateway to the VPC
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
echo "Attached Internet Gateway $IGW_ID to VPC $VPC_ID"

# Tag the Internet Gateway (optional)
aws ec2 create-tags --resources $IGW_ID --tags Key=Name,Value=$IGW_NAME
echo "Tagged Internet Gateway with Name: $IGW_NAME"

# Create a route table for the VPC (ProductionRouteTable)
ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text
