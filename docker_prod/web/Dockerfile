# Base Image
FROM ruby:2.7.1

# Encoding
# C.UTF8 locale supports Computer English language
ENV LANG C.UTF-8

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update -qq && \
    apt-get install -y curl         \
                       libpq-dev    \
                       libxml2-dev  \
                       libxslt1-dev \
                       imagemagick  \
                       git          \
                       sudo         \
                       ssh          \
                       rsync        \
                       procps       \
                       vim

# --------------------------
# INSTALL NODEJS BY NVM
# --------------------------
ARG NODE_VERSION=12.16.3
ARG NVM_DIR=/usr/local/nvm

# https://github.com/creationix/nvm#install-script
RUN mkdir $NVM_DIR && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v
# --------------------------
# end NODEJS
# --------------------------


# Install YARN
RUN npm install -g yarn

# Define environment variables
ENV APP_NAME cdms
ENV _USER devel
ENV HOME /home/${_USER}
ENV APP /var/www/${APP_NAME}
ENV BUNDLE_PATH /bundle/vendor

RUN addgroup --gid $GROUP_ID ${_USER}
RUN adduser  --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID ${_USER} \
  && usermod -a -G sudo ${_USER} \
  && usermod -a -G staff ${_USER} \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo "${_USER}:${_USER}" | chpasswd

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p $HOME \
  && mkdir -p $APP \
  && mkdir -p $BUNDLE_PATH \
  && chown -R ${_USER}:${_USER} $HOME \
  && chown -R ${_USER}:${_USER} $BUNDLE_PATH \
  && chown -R ${_USER}:${_USER} $APP

# Change current user
USER ${_USER}:${_USER}

# Set working directory
WORKDIR $APP

# Install bundler and rails
RUN gem install bundler -v 2.1.4 \
 && gem install rails -v 6.0.3.2
