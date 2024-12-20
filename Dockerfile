# https://docs.docker.com/reference/dockerfile/

# https://hub.docker.com/_/oraclelinux
# https://github.com/oracle/container-images/pkgs/container/oraclelinux
# https://github.com/oracle/container-images/blob/dist-amd64/9-slim/Dockerfile
FROM oraclelinux:9-slim

# https://github.com/oracle/docker-images/blob/main/OracleLinuxDevelopers/oraclelinux9/python/3.11/Dockerfile
RUN microdnf -y install python3.11 python3.11-libs python3.11-pip python3.11-setuptools python3.11-wheel && \
    rm -rf /var/cache/dnf

# https://pip.pypa.io/en/stable/cli/pip_install/
# https://docs.astral.sh/uv/getting-started/installation/#pypi
RUN /usr/bin/pip3.11 install uv

WORKDIR /app

ADD requirements.txt constraints.txt /app/

# https://docs.astral.sh/uv/pip/environments/
# https://docs.astral.sh/uv/pip/compatibility/
RUN uv venv && \
    uv pip install -r requirements.txt -c constraints.txt
    
# https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
ENV PATH="/app/.venv/bin:$PATH"

# https://airflow.apache.org/docs/apache-airflow/2.8.4/start.html
# https://airflow.apache.org/docs/apache-airflow/2.8.4/installation/installing-from-pypi.html

EXPOSE 8080

CMD ["airflow", "standalone"]