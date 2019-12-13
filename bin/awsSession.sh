#!/bin/bash
# Script to handle MFA with AWS CLI
# take credentials.master and add in new profiles dtk and aft
USAGE="$0: dtkMFA aftMFA"

AWSIN=~/.aws
AWSOUT=~/.aws
CREDS=$AWSIN/credentials.master

TOKENFILE=~/tmp/aws.out

# checks
if [ $# != 2 ]
then
    echo Missing MFA tokens
    echo -e $USAGE
    exit 3
fi

if [ ! -f $CREDS ]
then
    echo "missing $CREDS file on input"
    exit 1
fi

if [ ! -d $AWSOUT ]
then
    echo "missing output directory $AWSOUT"
    exit 2
fi

cp $CREDS $AWSOUT/credentials
chmod 600 $AWSOUT/credentials

# dtk account
echo Account dtk
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
echo Account aft
aws --profile ff sts get-session-token --serial-number 'arn:aws:iam::357369783546:mfa/aft-dtk' --token-code $2 > $TOKENFILE
AFT_AKID=`grep AccessKeyId $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
AFT_SAK=`grep SecretAccessKey $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
AFT_ST=`grep SessionToken $TOKENFILE | cut -f2 -d ':' | sed s/\"//g | sed s/,$// | xargs`
echo -e "\n " >> $AWSOUT/credentials
echo '[aft]' >> $AWSOUT/credentials
echo "aws_access_key_id = $AFT_AKID" >> $AWSOUT/credentials
echo "aws_secret_access_key = $AFT_SAK" >> $AWSOUT/credentials
echo "aws_session_token = $AFT_ST" >> $AWSOUT/credentials

rm -f $TOKENFILE




