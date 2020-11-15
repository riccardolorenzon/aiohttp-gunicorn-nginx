FROM python:3.8

LABEL maintainer="riccardo lorenzon <riccardo.lorenzon@gmail.com" 

RUN apt-get update && apt-get install -y nginx supervisor \
&& rm -rf /var/lib/apt/lists/*

RUN rm /etc/nginx/sites-available/default 
ADD ./ /app

RUN pip3 install -r /app/requirements.txt

# By default, Nginx will run a single worker process, setting it to auto
# will create a worker for each CPU core
ENV NGINX_WORKER_PROCESSES 1

# Custom Supervisord config
COPY supervisord-debian.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /app/start.sh

# Copy the entrypoint that will generate Nginx additional configs
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

WORKDIR /app
CMD ["/app/start.sh"]



