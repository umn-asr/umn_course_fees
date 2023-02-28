FROM gcc:9-buster AS lpass_builder

RUN apt update -y

RUN apt-get --no-install-recommends -yqq install \
  bash-completion \
  build-essential \
  cmake \
  libcurl4  \
  libcurl4-openssl-dev  \
  libssl-dev  \
  libxml2 \
  libxml2-dev  \
  libssl1.1 \
  pkg-config \
  ca-certificates \
  xclip

RUN mkdir -p /etc/lastpass-cli && cd /etc/lastpass-cli

# Download and extract lastpass-cli
RUN curl -fsSL https://github.com/lastpass/lastpass-cli/archive/v1.3.3.tar.gz -o lastpass-cli.tar.gz
RUN tar -xzf lastpass-cli.tar.gz -C /etc/lastpass-cli --strip-components 1

RUN mkdir -p /lpass

RUN export PATH="/usr/bin:$PATH" && export OPENSSL_ROOT_DIR=/usr/bin && cd /etc/lastpass-cli && PREFIX=/lpass make && PREFIX=/lpass make install

FROM asr-docker-local.artifactory.umn.edu/ruby_2_7_2_node_16_oracle:v0.0.1 as courses

COPY --from=lpass_builder /lpass/bin/lpass /usr/bin/lpass

COPY Gemfile Gemfile.lock ./

RUN mkdir -p /app
WORKDIR /app

ENV MAKE="make --jobs 8"

COPY . .

RUN bundle install --binstubs

CMD rails s
