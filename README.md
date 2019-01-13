# Prerequirement
- aws CLI
- jq 

# Usage
## Create config.env based on config.env.template

```:config.env.template
AccountID="YOUR AWS ACCOUNT ID"
BucketName="AWS S3 BUCKET NAME"
Region="REGION WHICH BUCKET IS IN"
FunctionName="LAMBDA FUNCTION NAME"
LambdaEndpointPath="LAMBDA FUNCTION PATH"
```

## Create api_response.json
Define json you can get  when you access LambdaEndpointPath.

## Deploy

```
sh deploy.sh
```

if deployment is succeeded, lambda endpoint can be shown in console like following.

```
Try following command to confirm lambda fuction working correctly
curl https://${REST_API_ID}.execute-api.${REGION}.amazonaws.com/prod/users -H accept: application/json -s | jq .
```
