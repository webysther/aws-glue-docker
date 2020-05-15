#!/bin/sh

# https://github.com/docker/cli/issues/267

# spark 0.9
docker image push  webysther/aws-glue:spark-0.9-py2
docker image push  webysther/aws-glue:spark-0.9

# spark python 2
docker image push  webysther/aws-glue:spark-1.0-py2
docker image push  webysther/aws-glue:spark-py2

# spark python 3
docker image push webysther/aws-glue:spark-1.0-py3
docker image push webysther/aws-glue:spark-py3
docker image push webysther/aws-glue:spark-1.0
docker image push webysther/aws-glue:spark

# shell python 2
docker image push webysther/aws-glue:shell-1.0-py2
docker image push webysther/aws-glue:shell-py2
docker image push webysther/aws-glue:py2

# shell python 3
docker image push  webysther/aws-glue:shell-1.0-py3
docker image push  webysther/aws-glue:shell-1.0
docker image push  webysther/aws-glue:shell-py3
docker image push  webysther/aws-glue:shell
docker image push  webysther/aws-glue:py3
docker image push  webysther/aws-glue:1.0
docker image push  webysther/aws-glue:1
docker image push  webysther/aws-glue:latest