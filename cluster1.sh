#!/bin/sh
set -x

echo "creating cluster-config.yaml file"
source ./apc-ve/bin/activate
echo "Activated Virtual Environment"
pcluster configure --config cluster-config.yaml
echo "Successfully Created Cluster-config.yaml in the present directory"


echo "Retrieving Tags from Running Instance"
INSTANCE_ID=`wget -qO- http://instance-data/latest/meta-data/instance-id`
REGION=`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed 's/.$//'`
aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID" --query 'Tags[*].{Key:Key,Value:Value}' >> a.json
echo "a.json file is updated with Tags"
yq eval -P a.json > b.yaml
echo "Json file is converted to yaml"
sed -i '1 i\Tags:' b.yaml
yq eval-all "select(fileIndex == 1) *+ select(fileIndex == 0)" b.yaml cluster-config.yaml >> cluster-config1.yaml
echo "b.yaml file and cluster-config.yaml file is merged into cluster-config1.yaml"
echo "Modified cluster-config.yaml with Tags"
source ./apc-ve/bin/activate
echo "Virtual Environmement Activated"
echo "creating Cluster with updated cluster-config1.yaml"
pcluster create-cluster --cluster-name test-cluster --cluster-configuration cluster-config1.yaml
echo "Success"
