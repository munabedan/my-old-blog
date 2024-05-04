# Use official Ruby image as base
FROM ruby:2.7.0-alpine

# Install Jekyll and other dependencies
RUN gem install bundler -v '~> 2.3.27'

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock for dependency installation
COPY Gemfile ./

# Install dependencies
RUN apk add --no-cache build-base \
    && bundle install

# Copy the project files
COPY . .

# Build the Jekyll site
RUN bundle exec jekyll build

# Expose port 4000
EXPOSE 4000

# Start the web server to serve Jekyll site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
