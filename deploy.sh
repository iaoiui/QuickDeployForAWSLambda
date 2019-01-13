#rm -rf aws-serverless-express
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
if [[ "`tail -n 1  app.js`" != *"const"* ]];then
echo $B >> app.js
else
sed -i -e '$d' app.js
echo $B >> app.js
fi
npm run setup
if [ `echo $?` == 0 ]; then 
REST_API_ID=`aws apigateway get-rest-apis | jq .items[0].id -r`
REGION=`cat package.json | jq .config.region -r`
cat << EOS
Try following command to confirm lambda fuction working correctly
EOS
cat << EOS
curl https://${REST_API_ID}.execute-api.${REGION}.amazonaws.com/prod/${endpoint} -H 'accept: application/json' -s | jq .
EOS
fi
