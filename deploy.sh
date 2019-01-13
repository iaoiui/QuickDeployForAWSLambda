git clone https://github.com/awslabs/aws-serverless-express.git
source ./config.env
cd aws-serverless-express/examples/basic-starter/
npm run config -- \
--account-id="${AccountID}" \
--bucket-name="${BucketName}" \
--region="${Region}" \
--function-name="${FunctionName}"

A="const response_json =""$(cat ../../../api_response.json);"
endpoint="$LambdaEndpointPath"
B=`cat << EOS
$A 
router.get('/$endpoint', (req, res) => {
  res.json(response_json)
})
EOS`
echo $B >> app.js

npm run setup
if [ `echo $?` == 0 ]; then 
REST_API_ID=`aws apigateway get-rest-apis | jq .items[0].id -r`
REGION=`cat package.json | jq .config.region -r`
echo  '\033[1;34mTry following command to confirm lambda fuction working correctly\033[0;39m'
echo  '\033[1;34mcurl https://${REST_API_ID}.execute-api.${REGION}.amazonaws.com/prod/${endpoint} -H 'accept: application/json' -s | jq .\033[0;39m'
fi
