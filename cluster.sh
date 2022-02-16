#!/bin/bash
set -x


echo "creating cluster-config.yaml file"
source ./apc-ve/bin/activate
echo "Activated Virtual Environment"
pcluster configure --config cluster-config.yaml
echo "Successfully Created Cluster-config.yaml in the present directory"

echo "Modifying cluster-config.yaml file"
if [ -f "./cluster-config.yaml" ]; then
        echo "cluster-config.yaml exists"
        sed -i '$aTags:\n- Key: \"Schedule\"\n  Value: \"Bangalore-office-hours\"' cluster-config.yaml
        sed -i '/^Tags.*/a - Key: \"Project\"\n  Value: \"HBC3.03\"' cluster-config.yaml
        sed -i '/^Tags.*/a - Key: \"Cost\"\n  Value: \"50\"' cluster-config.yaml
        sed -i '/^Tags.*/a - Key: \"Project_owner\"\n  Value: \"RL\"' cluster-config.yaml
        echo "Modified cluster-config.yaml with Tags"
        source ./apc-ve/bin/activate
        echo "Virtual Environmement Activated"
        echo "creating Cluster with updated cluster-config.yaml"
        pcluster create-cluster --cluster-name test-cluster --cluster-configuration cluster-config.yaml
        echo "Success"
fi
