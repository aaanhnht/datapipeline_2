FROM spark-base:latest

# Arguments for airflow dockerfile
ARG AIRFLOW_VERSION=2.1.4
ARG AIRFLOW_HOME=/opt/airflow

# Setup environment
ENV AIRFLOW_HOME=${AIRFLOW_HOME}

# Install dependencies
RUN apt-get update -y && \
    apt-get upgrade -yqq && \
    apt-get install -yqq --no-install-recommends \
    python3-dev \
    wget \
    libczmq-dev \
    curl \
    libssl-dev \
    git \
    inetutils-telnet \
    bind9utils freetds-dev \
    libkrb5-dev \
    libsasl2-dev \
    libffi-dev libpq-dev \
    freetds-bin build-essential \
    default-libmysqlclient-dev \
    apt-utils \
    rsync \
    zip \
    unzip \
    gcc \
    vim \
    netcat \
    && apt-get autoremove -yqq --purge && apt-get clean

# Upgrade pip, create airflow user and install airflow subpackages
RUN pip install --upgrade "pip==20.2.4" && \
    useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow && \
    pip install apache-airflow==${AIRFLOW_VERSION} --constraint https://raw.githubusercontent.com/apache/airflow/constraints-2.1.4/constraints-3.7.txt && \
    pip install apache-airflow-providers-apache-hdfs==2.1.0 && \
    pip install apache-airflow-providers-apache-hive==2.0.2 && \
    pip install apache-airflow-providers-apache-spark==2.0.1 && \
    pip install apache-airflow-providers-slack==4.0.1 && \
    pip install apache-airflow-providers-http==2.0.1

# Copy airflow.cfg file from host to Docker airflow container
#COPY ./config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

# Set "airflow" user as owner of files in AIRFLOW_HOME
RUN chown -R airflow: ${AIRFLOW_HOME}

# Copy start-airflow.sh from host to Docker airflow container
COPY ./start-airflow.sh ./start-airflow.sh

# Set permission for start-airflow.sh
RUN chmod +x ./start-airflow.sh

# Set the username to use
USER airflow

# Create dags folder in Docker airflow container
RUN mkdir -p ${AIRFLOW_HOME}/dags

# Expose 8080 port
EXPOSE 8080

# Run start-airflow.sh
CMD [ "./start-airflow.sh" ]