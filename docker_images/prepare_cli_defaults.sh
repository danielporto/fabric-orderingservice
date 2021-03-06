#!/bin/bash

function main () {

	dir=./cli_material

	if [ ! -z $1 ]; then

		dir=$1	
	fi

	# docker pull bftsmart/fabric-tools:amd64-1.3.0
	if [[ "$(docker images -q bftsmart/fabric-tools:amd64-1.3.0 2> /dev/null)" == "" ]]; then
	  # do something
	  echo "The required docker image is not build yet. Run the create-container-images-multipeers.sh script first."
	  echo "Anternativelly uncomment the pull command in this script to use the default container."
	  exit
	fi

	docker create --name="cli-temp" "bftsmart/fabric-tools:amd64-1.3.0" > /dev/null
	id=$(docker ps -aqf "name=cli-temp")

	if [ ! -d $dir ]; then
	    mkdir $dir
	fi

	if [ ! -d $dir/fabric ]; then

		docker cp $id:/etc/hyperledger/fabric/ $dir/

		if [ -f $dir/fabric/configtx.yaml ]; then

			rm $dir/fabric/configtx.yaml

		fi

		if [ -f $dir/fabric/orderer.yaml ]; then

			rm $dir/fabric/orderer.yaml

		fi

		if [ -d $dir/fabric/etcdraft ]; then

			rm -r $dir/fabric/etcdraft/

		fi

	fi

	docker rm -v $id > /dev/null

	echo ""
	echo "Default configuration available at '$dir'"
	echo ""
}

main $@
