FROM asr-docker-local.artifactory.umn.edu/ruby_2_7_oracle_19_10:latest

# Install lastpass-cli dependencies
RUN \
 apt-get update && \
 apt-get -y upgrade && \
 apt-get --no-install-recommends -yqq install \
  bash \
  bash-completion \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  g++ \
  libcurl3-gnutls  \
  libcurl3-openssl-dev  \
  libssl1.0 \
  libssl-dev \
  libxml2 \
  libxml2-dev  \
  make \
  openssh-client \
  pkg-config \
  tar \
  xclip

ENV OPENSSL_ROOT_DIR=/usr/bin/openssl

RUN mkdir -p /etc/lastpass-cli && cd /etc/lastpass-cli

# Download and extract lastpass-cli
RUN curl -fsSL https://github.com/lastpass/lastpass-cli/archive/v1.3.3.tar.gz -o lastpass-cli.tar.gz
RUN tar -xzf lastpass-cli.tar.gz -C /etc/lastpass-cli --strip-components 1
# cd into the repo directory

# Follow the "Build" instructions here: https://github.com/lastpass/lastpass-cli#building
# * make
# * make install
RUN export PATH="/usr/bin:$PATH" && export OPENSSL_ROOT_DIR=/usr/bin && cd /etc/lastpass-cli && make && make install

COPY Gemfile Gemfile.lock ./

RUN mkdir -p /app
WORKDIR /app

ENV MAKE="make --jobs 8"

COPY . .

RUN gem install bundler -v "~> 1.17.3" && bundle install --binstubs
