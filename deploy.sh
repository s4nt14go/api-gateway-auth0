#!/usr/bin/env bash

if [ "$1" == "h" ]; then
  echo -e "Run it with:
  ./$(basename "$0") <1>
\nWhere:
  <1>     Stack name"
  exit 0
fi

sam build
sam package --s3-bucket $1-stack-package --template-file .aws-sam/build/template.yaml --output-template-file template-package.yaml
sam deploy --template-file template-package.yaml --stack-name $1 --capabilities CAPABILITY_IAM
