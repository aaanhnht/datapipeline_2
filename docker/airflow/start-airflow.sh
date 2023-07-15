#!/usr/bin/env bash

# Create the user airflowin the HDFS
hdfs dfs -mkdir -p /user/airflow/
hdfs dfs -chmod g+w /user/airflow

# Move to the AIRFLOW HOME directory
cd $AIRFLOW_HOME

# Export environment variables
export AIRFLOW__CORE__LOAD_EXAMPLE=False

# Init Airflow db
airflow db init

# create user
airflow users create -u "airflow" -f "airflow" -l "airflow" -p "airflow" -r "Admin" -e "admin@airflow.com"  

# Run Airflow Scheduler
airflow scheduler &> /dev/null &

# Run Airflow Webserver
exec airflow webserver