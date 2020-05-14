FROM webysther/aws-glue-docker:spark-1.0-py2

USER root

RUN apt-get -q update -y && \
	apt-get -qq install -y libpq-dev gcc && \
	rm -rf /var/lib/apt/lists/*

RUN python -m pip install colorama docutils futures jmespath numpy pandas pip pyasn1
RUN python -m pip install pygresql python-dateutil pytz pyyaml rsa s3transfer 
RUN python -m pip install scikit-learn scipy setuptools six virtualenv wheel

USER docker