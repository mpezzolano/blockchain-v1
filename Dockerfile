FROM ubuntu:16.04

ENV HOME /root

RUN apt-get update && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      libssl-dev \
      libreadline6-dev \
      curl \
      tzdata \
      git-core \
      libffi-dev \
      apt-transport-https && \
    apt-get clean

# Install nvm && Node
ENV NVM_DIR $HOME/.nvm
ENV NODE_VERSION 6.9.5

Run curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Setup SSH
ENV SSH_PATH $HOME/.ssh

RUN mkdir $SSH_PATH && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" >> $SSH_PATH/config

# Setup App dir
ENV APP_HOME /var/www
WORKDIR $APP_HOME

ENV PATH $APP_HOME/node_modules/.bin:$PATH

ENTRYPOINT ["./entrypoint.sh"]
