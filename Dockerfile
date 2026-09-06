FROM ruby:3.3.0-slim AS base
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN bundle exec rails assets:precompile

FROM base AS production
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
