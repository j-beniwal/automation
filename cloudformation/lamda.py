import json
import boto3
import os
def lambda_handler(event, context):
    sns = boto3.client('sns')
    
    response = sns.publish(
        TopicArn=os.environ['TopicArn'],  
        Message='Hello World!',    
    )
    
    print(response)
    return{
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
