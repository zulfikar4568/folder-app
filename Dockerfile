FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

WORKDIR /folder-app
COPY . ./

COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle update mimemagic && bundle install --verbose --jobs 20 --retry 5 && \
    yarn install --check-files
RUN yarn install
RUN yarn add bootstrap jquery popper.js


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]