FROM svajiraya/glue-dev-1.0:20200513_151648UTC as glue
FROM openjdk:8-jdk-slim-buster as spark

# Dependencies 
RUN apt-get -q update -y && \
	apt-get -qq install -y curl git && \
	rm -rf /var/lib/apt/lists/*

# Maven
RUN curl -SsL https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-common/apache-maven-3.6.0-bin.tar.gz | tar -C /opt --warning=no-unknown-keyword -xzf - 

# Spark
RUN curl -SsL https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-1.0/spark-2.4.3-bin-hadoop2.8.tgz | tar -C /opt --warning=no-unknown-keyword -xzf - 

# AWS glue scripts (get from freezed fork)
RUN git clone --depth 1 -b glue-1.0 --single-branch https://github.com/webysther/aws-glue-libs.git /opt/aws-glue-libs

# Python
FROM python:3.6.9-slim-buster
COPY --from=spark /usr/local/openjdk-8 /usr/local/openjdk-8
COPY --from=spark /opt/spark-2.4.3-bin-spark-2.4.3-bin-hadoop2.8 /opt/spark-2.4.3-bin-spark-2.4.3-bin-hadoop2.8
COPY --from=spark /opt/apache-maven-3.6.0 /opt/apache-maven-3.6.0
COPY --from=spark /opt/aws-glue-libs /opt/aws-glue-libs
COPY --from=glue /glue/jarsv1 /opt/aws-glue-libs/jarsv1
COPY --from=glue /glue/PyGlue.zip /opt/aws-glue-libs/PyGlue.zip

# Dependencies
RUN apt-get update -q -y && \
	apt-get install -q -y curl git zip vim wget && \
	curl -sL https://deb.nodesource.com/setup_12.x  | bash - && \
	apt-get -y install nodejs  && \
	rm -rf /var/lib/apt/lists/*

# pip
RUN python -m pip install --upgrade pip

# aws cli
RUN python -m pip install awscli && python -m pip install -U pytest

# cdk
RUN npm install -g aws-cdk

# samples
RUN git clone --depth 1 https://github.com/aws-samples/aws-glue-samples /opt/aws-glue-samples && \
	ln -s  /opt/aws-glue-samples/examples/ /opt/samples

# User
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /home/docker --shell /bin/sh --disabled-password --gecos "" docker

RUN chown -R docker:docker /opt
RUN chown -R docker:docker /usr/local

USER docker:docker

# Env
ENV JAVA_HOME=/usr/local/openjdk-8
ENV M2_HOME=/opt/apache-maven-3.6.0
ENV SPARK_HOME=/opt/spark-2.4.3-bin-spark-2.4.3-bin-hadoop2.8
ENV GLUE_HOME=/opt/aws-glue-libs

ENV PATH="${JAVA_HOME}/bin:${PATH}:${M2_HOME}/bin:${GLUE_HOME}/bin/"

ENV GLUE_PY_FILES=$GLUE_HOME/PyGlue.zip
ENV SPARK_CONF_DIR=$GLUE_HOME/conf
ENV GLUE_JARS_DIR=$GLUE_HOME/jarsv1

ENV PYTHONPATH="${SPARK_HOME}/python/:${PYTHONPATH}"
ENV PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.7-src.zip:${PYTHONPATH}"
ENV PYTHONPATH="${GLUE_PY_FILES}:${PYTHONPATH}"

ENV PATH="/home/docker/.poetry/bin:$PATH"
ENV PATH="/home/docker/.local/bin:$PATH"

# Generate spark-defaults.conf
RUN mkdir $SPARK_CONF_DIR
RUN echo "spark.driver.extraClassPath $GLUE_JARS_DIR/*" >> $SPARK_CONF_DIR/spark-defaults.conf
RUN echo "spark.executor.extraClassPath $GLUE_JARS_DIR/*" >> $SPARK_CONF_DIR/spark-defaults.conf

# Changed scripts
RUN echo '#!/usr/bin/env bash \n\n exec "${SPARK_HOME}/bin/spark-submit" --py-files "${GLUE_PY_FILES}" "$@"' > $GLUE_HOME/bin/gluesparksubmit
RUN echo '#!/usr/bin/env bash \n\n exec "${SPARK_HOME}/bin/pyspark" "$@"' > $GLUE_HOME/bin/gluepyspark
RUN echo '#!/usr/bin/env bash \n\n exec pytest "$@"' > $GLUE_HOME/bin/gluepytest
RUN cp $GLUE_HOME/bin/gluepytest $GLUE_HOME/bin/pytest && \
	cp $GLUE_HOME/bin/gluepyspark $GLUE_HOME/bin/pyspark && \
	cp $GLUE_HOME/bin/gluesparksubmit $GLUE_HOME/bin/sparksubmit
RUN rm $GLUE_HOME/bin/glue-setup.sh

RUN wget -O $SPARK_CONF_DIR/log4j.properties https://gist.githubusercontent.com/svajiraya/aecb45c038e7bba86429646a68b542bb/raw/0cc6229d3b745a0092be75bbbf9476fa17318004/log4j.properties

# pip
RUN python -m pip install --user --upgrade pip && \
	python -m pip install --user boto3

# poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && \
	poetry config virtualenvs.create false

WORKDIR /app
CMD ["bash"]