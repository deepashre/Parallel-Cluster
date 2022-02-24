#!/bin/bash


echo "creating cluster-config.yaml file"
source ./apc-ve/bin/activate
echo "Activated Virtual Environment"
pcluster configure --config cluster-config.yaml
echo "Successfully Created Cluster-config.yaml in the present directory"


echo "Retrieving Tags from Running Instance"
INSTANCE_ID=`wget -qO- http://instance-data/latest/meta-data/instance-id`
REGION=`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed 's/.$//'`
aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID" --query 'Tags[*].{Key:Key,Value:Value}' | jq -r '.[] | select( .Key as $a | ["cost_resource", "project_name","researcher_name","Schedule"] | index($a) )' >> out.json
jq -s '.' out.json >> valid.json
echo "valid.json file is updated with Tags"
yq eval -P valid.json > valid.yaml
echo "Json file is converted to yaml"
sed -i '1 i\Tags:' valid.yaml
yq eval-all "select(fileIndex == 1) *+ select(fileIndex == 0)" valid.yaml cluster-config.yaml >> cluster-config1.yaml
echo "valid.yaml file and cluster-config.yaml file is merged into cluster-config1.yaml"
echo "Modified cluster-config1.yaml with Tags"
source ./apc-ve/bin/activate
echo "Virtual Environmement Activated"
echo "creating Cluster with updated cluster-config1.yaml"
pcluster create-cluster --cluster-name test-cluster --cluster-configuration cluster-config1.yaml
echo "Success"
