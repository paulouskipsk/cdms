# Base image
FROM steveltn/https-portal:1

# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils

VOLUME /etc/letsencrypt
EXPOSE 80
EXPOSE 443

# Do this apt/pip stuff all in one RUN command to avoid creating large
# intermediate layers on non-squashable docker installs
RUN apt update && \
    apt install -y python3 python3-dev libffi6 libffi-dev libssl-dev curl build-essential procps && \
    curl -L 'https://bootstrap.pypa.io/get-pip.py' | python3 && \
    pip install -U cffi certbot && \
    apt remove --purge -y python3-dev build-essential libffi-dev libssl-dev curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# establish where Nginx should look for files
ENV RAILS_ROOT /var/www/cdms

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
