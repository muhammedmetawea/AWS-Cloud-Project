aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications '{"ResourceType": "vpc", "Tags": [{"Key": "Name", "Value": "VPC1"}]}'
aws ec2 create-vpc --cidr-block 172.31.0.0/16 --tag-specifications '{"ResourceType": "vpc", "Tags": [{"Key": "Name", "Value": "VPC2"}]}'
# For VPC1
aws ec2 create-subnet --vpc-id <vpc1-id> --cidr-block 10.0.0.0/24 --availability-zone us-east-1a
aws ec2 create-subnet --vpc-id <vpc1-id> --cidr-block 10.0.1.0/24 --availability-zone us-east-1b

# For VPC2
aws ec2 create-subnet --vpc-id <vpc2-id> --cidr-block 172.31.0.0/24 --availability-zone us-east-1a
aws ec2 create-subnet --vpc-id <vpc2-id> --cidr-block 172.31.1.0/24 --availability-zone us-east-1b

aws ec2 create-vpc-peering-connection --requester-vpc-id <vpc1-id> --responder-vpc-id <vpc2-id>
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id <vpc-peering-connection-id>
aws ec2 describe-vpc-peering-connections --vpc-peering-connection-id <vpc-peering-connection-id>
aws ec2 create-vpc-peering-connection --requester-vpc-id vpc-0123456789abcdef --responder-vpc-id vpc-0987654321fedcba

