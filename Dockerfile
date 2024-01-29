FROM asr-docker-local.artifactory.umn.edu/ruby_3_2_2_oracle_19_10_multiarch:1.0.0 as courses

COPY Gemfile Gemfile.lock ./

RUN mkdir -p /app
WORKDIR /app

ENV MAKE="make --jobs 8"

COPY . .

RUN bundle install

CMD rails s
