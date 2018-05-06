#!/bin/bash

image_name='flask_image_hosting'
name='image_hosting'

case $1 in
['build']*)
	sudo docker build -t $image_name .
	;;
['start']*)
	sudo docker run --rm --name $name -p 5000:5000 $image_name
	;;
['stop']*)
	sudo docker stop $name
	;;
*)
    sudo docker build -t $image_name .
    sudo docker run --rm --name $name -p 5000:5000 $image_name
    ;;
esac
