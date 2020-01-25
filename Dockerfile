FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /ClubReady
WORKDIR /ClubReady

COPY Gemfile /ClubReady/Gemfile
COPY Gemfile.lock /ClubReady/Gemfile.lock

RUN bundle install

COPY . /ClubReady

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]