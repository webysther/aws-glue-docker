# Supported tags and respective `Dockerfile` links

## Simple Tags

### Python Shell

-	[`shell-1.0-py3`, `shell-1.0`, `shell-py3`, `shell`, `py3`, `1.0`, `1`, `latest`](https://github.com/webysther/aws-glue-docker/blob/master/src/shell/py3/Dockerfile)
-	[`shell-1.0-py2`, `shell-py2`, `py2`](https://github.com/webysther/aws-glue-docker/blob/master/src/shell/py2/Dockerfile)

### Spark

-	[`spark-1.0-py3`, `spark-py3`, `spark-1.0`, `spark`](https://github.com/webysther/aws-glue-docker/blob/master/src/spark/1.0/py3/Dockerfile)
-	[`spark-1.0-py2`, `spark-py2`](https://github.com/webysther/aws-glue-docker/blob/master/src/spark/1.0/py2/Dockerfile)
-	[`spark-0.9-py2`, `spark-0.9`](https://github.com/webysther/aws-glue-docker/blob/master/src/spark/0.9/Dockerfile)

# AWS Glue Docker

[![Software License](https://goo.gl/FU2Kw1)](LICENSE)

AWS Glue Development enviroment based on [svajiraya/aws-glue-libs](https://github.com/svajiraya/aws-glue-libs) [fix](https://github.com/awslabs/aws-glue-libs/issues/25#issuecomment-628064396).

- [Announced released bin '19](https://aws.amazon.com/pt/about-aws/whats-new/2019/08/aws-glue-releases-binaries-of-glue-etl-libraries-for-glue-jobs/)
- [Python Shell Supported Library](https://docs.aws.amazon.com/glue/latest/dg/add-job-python.html#python-shell-supported-library)
- [Python Shell version running](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html)
- [Glue lib reference](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python.html)
- [Glue Dynamic frames](https://youtu.be/PHYWI4Y9mzs?t=1226)
- [Glue script samples](https://github.com/aws-samples/aws-glue-samples)
- packaged with: debian 10, ppenJDK 8, spark 2.4, maven 3.6, python 3.6, pip 20, pytest, glue lib, boto3
- additionally: aws cli, cdk, [glue Samples](https://github.com/aws-samples/aws-glue-samples) inside `/opt/samples`, poetry

## Getting started

```bash
# register alias
alias glue='docker run -v $PWD:/app -v ~/.aws:/home/docker/.aws -u $(id -u ${USER}):$(id -g ${USER}) -it webysther/aws-glue "$@"'
alias glue-spark='docker run -v $PWD:/app -v ~/.aws:/home/docker/.aws -u $(id -u ${USER}):$(id -g ${USER}) -it webysther/aws-glue:spark "$@"'

# bash
glue

# Glue Python Shell
# /app is you current folder
glue python
glue python /app/script.py

# Glue PySpark (REPL) 
glue-spark pyspark

# Glue PySpark
# /app is you current folder
glue-spark sparksubmit /app/spark_script.py

# Pyspark vanilla (without glue lib)
glue-spark
$ ./${SPARK_HOME}/bin/spark-submit spark_script.py

# Test
glue pytest

# aliases (backwards compatibility)
gluesparksubmit == sparksubmit
gluepyspark == pyspark
gluepytest == pytest
```
