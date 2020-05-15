#!/bin/sh

if ! docker build --rm -t webysther/aws-glue:spark-1.0-py3 \
						-t webysther/aws-glue:spark-py3 \
						-t webysther/aws-glue:spark-1.0 \
						-t webysther/aws-glue:spark \
							src/spark/1.0/py3; 
then
    exit
fi

if ! docker build --rm -t webysther/aws-glue:spark-1.0-py2 \
						-t webysther/aws-glue:spark-py2 \
							src/spark/1.0/py2; 
then
    exit
fi

if ! docker build --rm -t webysther/aws-glue:spark-0.9-py2 \
						-t webysther/aws-glue:spark-0.9 \
							src/spark/0.9; 
then
    exit
fi

if ! docker build --rm -t webysther/aws-glue:shell-1.0-py3 \
						-t webysther/aws-glue:shell-1.0 \
						-t webysther/aws-glue:shell-py3 \
						-t webysther/aws-glue:shell \
						-t webysther/aws-glue:py3 \
						-t webysther/aws-glue:1.0 \
						-t webysther/aws-glue:1 \
						-t webysther/aws-glue:latest \
							src/shell/py3; 
then
    exit
fi

if ! docker build --rm -t webysther/aws-glue:shell-1.0-py2 \
						-t webysther/aws-glue:shell-py2 \
						-t webysther/aws-glue:py2 \
							src/shell/py2;
then
    exit
fi
