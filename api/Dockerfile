FROM ruby:3.3.3

RUN apt-get update && \
    apt-get install -y nodejs && \
    gem install bundler && \
    echo 'gem: --no-document' > /root/.gemrc

WORKDIR /api

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 8

COPY . .

EXPOSE 3000

# change later
CMD ["/bin/bash"]
