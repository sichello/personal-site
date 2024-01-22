import json
import boto3


print('Loading function')
dynamo = boto3.client('dynamodb')


def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'headers': {
            'Access-Control-Allow-Origin' : '*',
            'Access-Control-Allow-Headers':'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
            'Access-Control-Allow-Credentials' : 'true',
            'Content-Type': 'application/json'
        },
        'body': str(
            err) if err else json.dumps(res),
    }



def lambda_handler(event, context):
    operation = event['httpMethod']
    
    key = {
        'site':{'S':'sichello'}
    }
           
    if operation == 'GET':
        # Retrieve item from DynamoDB
        response = dynamo.get_item(TableName='visitorCounter', Key=key)
        

    
    
    elif operation == 'POST':
        print('In POST')
        # Update item in DynamoDB to increment the 'count' attribute
        updateResponse = dynamo.update_item(
            TableName='visitorCounter',
            Key=key,
            UpdateExpression='SET #count = #count + :increment',
            ExpressionAttributeNames={'#count': 'count'},
            ExpressionAttributeValues={':increment': {'N': '1'}}
        )
        print(json.dumps(updateResponse))
        response = dynamo.get_item(TableName='visitorCounter', Key=key)
        
    else:
        return respond(ValueError('Unsupported method "{}"'.format(operation)))
        
    
    # Check if the item exists
    if 'Item' in response:
        count = (response['Item']['count']['N'])
        return respond(None, response['Item'])
    else:
        return respond(ValueError('Item not found'))
    

    
