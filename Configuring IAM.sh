#!/bin/bash

# Variables 
USER_NAME="production-user"
GROUP_NAME="admins-group"
POLICY_NAME="S3ReadOnlyAccessPolicy"
BUCKET_NAME="company-production-bucket"
ACCOUNT_ID="123456789012"
ROLE_NAME="EC2S3AccessRole"

# Create a new IAM user
aws iam create-user --user-name $USER_NAME
echo "Created IAM user: $USER_NAME"

# Create a new IAM group
aws iam create-group --group-name $GROUP_NAME
echo "Created IAM group: $GROUP_NAME"

# Add the user to the group
aws iam add-user-to-group --user-name $USER_NAME --group-name $GROUP_NAME
echo "Added $USER_NAME to $GROUP_NAME"

# Create a new IAM policy with S3 permissions (Read-Only Access to a specific bucket)
aws iam create-policy --policy-name $POLICY_NAME --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::'$BUCKET_NAME'/*"
            ]
        }
    ]
}'
echo "Created IAM policy: $POLICY_NAME"

# Attach the policy to the user
aws iam attach-user-policy --user-name $USER_NAME --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/$POLICY_NAME
echo "Attached $POLICY_NAME to $USER_NAME"

# Create a new IAM role for EC2 with an assume role policy
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}'
echo "Created IAM role: $ROLE_NAME"
