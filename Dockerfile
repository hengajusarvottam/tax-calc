# Build stage
FROM ruby:3.2.2-alpine AS build

RUN apk add \
    build-base \
    libpq-dev \
    postgresql-dev

ENV RAILS_ENV development

WORKDIR /opt/tax

COPY Gemfile Gemfile.lock .ruby-version ./

RUN bundle install

#COPY . .

#RUN bundle lock --add-platform ruby && bundle install

# Runtime stage
FROM ruby:3.2.2-alpine AS runtime

RUN apk add \
      tzdata \
      nodejs \
      postgresql-dev

WORKDIR /opt/tax

# Copy only necessary files from the build stage
COPY --from=build  /usr/local/bundle/ /usr/local/bundle/

COPY . .

EXPOSE 3000
CMD sh -c "/bin/sh start.sh"