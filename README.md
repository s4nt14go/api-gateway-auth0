<h1 align="center">AWS API Gateway Custom Authorizer using Auth0 🔒</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
  <a href="#" target="_blank">
    <img alt="License: ISC" src="https://img.shields.io/badge/License-ISC-yellow.svg" />
  </a>
</p>

### Description

We will build an endpoint protected with Auth0, only those applications with the correct Auth0 credentials will be able to consume our endpoint. Last but not least, all serverless using AWS Serverless Application Model (SAM) 💫

### Requirements

* [Auth0 account](https://auth0.com)
* [AWS account](https://aws.amazon.com)
* [AWS CLI](https://aws.amazon.com/cli)
* [AWS Serverless Application Model (SAM) CLI](https://aws.amazon.com/serverless/sam) 

### Auth0 configuration 🔒

1. You can use an existent tenant o create one to keep things more organized.
1. Create an API, name it and enter an identifier/audience (it's just a name to identified this API inside our tenant).
1. For our custom authorizer we'll need some data from this API we just created:
 * The audience which is our Auth0 API **identifier**
 * The issuer which is **https://`<your tenant name>`.`<region>`.auth0.com**
 
### AWS deployment 🚀

1. Clone this repo<br /><br />
`git clone https://github.com/s4nt14go/api-gateway-auth0`<br /><br />
1. Create file `auth0/.env` putting your data:<br />
```bash
AUDIENCE=<your Auth0 data>
ISSUER=<your Auth0 data>
```
1. Check your are using your AWS credentials and the region you want<br /><br />
`aws configure list`<br /><br />
1. Choose a name for your stack<br /><br />
`STACK=<name it>`<br /><br />
1. Create a bucket where we will upload the need files to AWS<br /><br />
`aws s3 mb s3://$STACK-stack-package`<br /><br />
1. Deploy it!<br /><br />
`bash deploy.sh $STACK`<br /><br />
1. Once CloudFormation finishes, it will output the root url for our protected API endpoint, save it in an environmental variable as we will need later but pay attention to not copy the last trailing slash "/"<br /><br />
`API=<CloudFormation output>`

### Check ✔️

1. Get a token from Auth0 going to the Test tab in your API, there grab the command that should look something like this:<br /><br />
    ```bash
    curl --request POST \
      --url https://<your tenant>.<region>.auth0.com/oauth/token \
      --header 'content-type: application/json' \
      --data '{"client_id":"<generated by Auth0>","client_secret":"<generated by Auth0>","audience":"<your api identifier>","grant_type":"client_credentials"}'
    ```
    


1. You'll get an object as response, put `access_token` field in an environmental variable:<br /><br />
`TOKEN=<access_token from Auth0>`<br /><br />
1. Consume our protected endpoint!<br /><br />
`curl --request GET --url $API/hello -H "Authorization: Bearer $TOKEN"`

You should receive the message "Autenticated call", you can also `curl` without the header part and you will get "Unauthorized"
