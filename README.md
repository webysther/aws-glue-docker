# AWS Glue Docker

AWS [Glue Development](https://aws.amazon.com/pt/about-aws/whats-new/2019/08/aws-glue-releases-binaries-of-glue-etl-libraries-for-glue-jobs/) 
enviroment base on [svajiraya/aws-glue-libs](https://github.com/svajiraya/aws-glue-libs) [fix](https://github.com/awslabs/aws-glue-libs/issues/25#issuecomment-628064396).

Glue Pyspark `:spark`

- debian "buster" 10.4
- OpenJDK 8
- spark 2.4.3
- maven 3.6
- [python 3.6.9](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html)
- pip 20
- Pytest 5.x
- [ETL library 0.9/1.0](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python.html) like [dynamic frames](https://youtu.be/PHYWI4Y9mzs?t=1226)
- Boto3

Glue Python Shell `:shell`

- collections
- CSV
- gzip
- multiprocessing
- NumPy
- pandas
- pickle
- PyGreSQL
- re
- SciPy
- sklearn
- sklearn.feature_extraction
- sklearn.preprocessing
- xml.etree.ElementTree
- zipfile

Plus

- aws cli
- cdk
- User/group id 1000
- [Glue Samples](https://github.com/aws-samples/aws-glue-samples) inside `/opt/samples`
- Poetry 1.x

## Using

### Supported

Glue [Python Shell](https://docs.aws.amazon.com/glue/latest/dg/add-job-python.html#python-shell-supported-library) 1.0 (recommended)

```bash
docker run -v $PWD:/app \
			-v ~/.aws:/home/docker/.aws \
			-u $(id -u ${USER}):$(id -g ${USER}) \
			-it webysther/aws-glue-docker:shell-py3
```

Glue pyspark 1.0

```bash
docker run -v $PWD:/app \
			-v ~/.aws:/home/docker/.aws \
			-u $(id -u ${USER}):$(id -g ${USER}) \
			-it webysther/aws-glue-docker:spark-1.0-py3
```

### Not supported (migration only)

Disclamer: [python 2 EOL](https://www.python.org/dev/peps/pep-0373/)

#### Python 2.7

Glue pyspark 1.0

```bash
docker run -v $PWD:/app \
			-v ~/.aws:/home/docker/.aws \
			-u $(id -u ${USER}):$(id -g ${USER}) \
			-it webysther/aws-glue-docker:spark-1.0-py2
```

Glue pyspark 0.9

```bash
docker run -v $PWD:/app \
			-v ~/.aws:/home/docker/.aws \
			-u $(id -u ${USER}):$(id -g ${USER}) \
			-it webysther/aws-glue-docker:spark-0.9
```

Glue [Python Shell](https://docs.aws.amazon.com/glue/latest/dg/add-job-python.html#python-shell-supported-library) 1.0

```bash
docker run -v $PWD:/app \
			-v ~/.aws:/home/docker/.aws \
			-u $(id -u ${USER}):$(id -g ${USER}) \
			-it webysther/aws-glue-docker:shell-py2
```

## Glue

Glue Python Shell

```bash
python script.py
```

Glue PySpark (REPL)

```bash
pyspark
```

Glue PySpark

```bash
sparksubmit spark_script.py

# vanilla (without glue lib)
./${SPARK_HOME}/bin/spark-submit spark_script.py
```

Test

```bash
pytest spark_script.py
```

## Aliases

- gluesparksubmit == sparksubmit
- gluepyspark == pyspark
- gluepytest == pytest

## Build wheel

```bash
poetry build -f wheel
```

## Build docker

```bash
docker build --rm -t webysther/aws-glue-docker .
```