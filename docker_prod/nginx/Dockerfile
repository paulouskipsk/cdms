# Base image
FROM nginx

# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils
RUN apt-get install -y curl && apt-get -y install software-properties-common    
RUN apt-get update && add-apt-repository ppa:certbot/certbot
RUN apt install certbot python3-certbot-nginx -y

# establish where Nginx should look for files
ENV RAILS_ROOT /var/www/cdms

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
