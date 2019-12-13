#!/bin/bash

AWSIN=~/.aws
AWSOUT=~/tmp
CREDS=$AWSIN/credentials.master

TOKENFILE=~/tmp/aws.out

cp $CREDS $AWSOUT/credentials
chmod 600 $AWSOUT/credentials

# dtk account
aws --profile default sts get-session-token --serial-number 'arn:aws:iam::100311576175:mfa/dtk' --token-code $1 > $TOKENFILE
DTK_AKID=`grep AccessKeyId $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
DTK_SAK=`grep SecretAccessKey $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
DTK_ST=`grep SessionToken $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
echo -e "\n " >> $AWSOUT/credentials
echo '[dtk]' >> $AWSOUT/credentials
echo "aws_access_key_id = $DTK_AKID" >> $AWSOUT/credentials
echo "aws_secret_access_key = $DTK_SAK" >> $AWSOUT/credentials
echo "aws_session_token = $DTK_ST" >> $AWSOUT/credentials

# aft account
aws --profile ff sts get-session-token --serial-number 'arn:aws:iam::357369783546:mfa/aft-dtk' --token-code $2 > $TOKENFILE
AFT_AKID=`grep AccessKeyId $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
AFT_SAK=`grep SecretAccessKey $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
AFT_ST=`grep SessionToken $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
echo -e "\n " >> $AWSOUT/credentials
echo '[aft]' >> $AWSOUT/credentials
echo "aws_access_key_id = $AFT_AKID" >> $AWSOUT/credentials
echo "aws_secret_access_key = $AFT_SAK" >> $AWSOUT/credentials
echo "aws_session_token = $AFT_ST" >> $AWSOUT/credentials





