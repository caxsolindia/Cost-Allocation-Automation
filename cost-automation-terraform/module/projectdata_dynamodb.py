import boto3
import json
import os

def lambda_handler(event, context):
    dynamodb_table = 'project-database'
    s3_bucket = 'aws-foundation-projectdata-bucket'
    s3_key = 'data'

    # Initialize DynamoDB and S3 clients
    dynamodb = boto3.client('dynamodb')
    s3 = boto3.client('s3')

    # Scan DynamoDB table
    response = dynamodb.scan(TableName=dynamodb_table)
    items = response['Items']

    # Convert DynamoDB items to JSON
    data = json.dumps(items)

    # Upload data to S3
    s3.put_object(Body=data, Bucket=s3_bucket, Key=s3_key)

    return {
        'statusCode': 200,
        'body': json.dumps('Data exported to S3 successfully!')
    }
