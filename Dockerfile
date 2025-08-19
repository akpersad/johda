FROM --platform=linux/amd64 ruby:2.3.8-stretch

# Snapshot repos and allow expired signatures
RUN printf 'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20200301T000000Z stretch main\n' > /etc/apt/sources.list \
 && printf 'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian-security/20200301T000000Z stretch/updates main\n' >> /etc/apt/sources.list \
 && printf 'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20200301T000000Z stretch-updates main\n' >> /etc/apt/sources.list \
 && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid \
 && echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/99insecure \
 && apt-get -o Acquire::Check-Valid-Until=false update -y \
 && apt-get -o Dpkg::Options::="--force-confnew" --allow-unauthenticated install -y --no-install-recommends \
    build-essential \
    sqlite3 \
    libsqlite3-dev \
    nodejs \
    ca-certificates \
    curl \
    gnupg \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

ENV BUNDLER_VERSION=1.17.3
RUN gem install bundler -v ${BUNDLER_VERSION}

WORKDIR /app

# Cache bundle layer
COPY Gemfile Gemfile.lock ./
# Exclude doc group to avoid rdoc at runtime
ENV BUNDLE_WITHOUT=doc
RUN bundle _${BUNDLER_VERSION}_ update rdoc --conservative --full-index || true \
 && bundle _${BUNDLER_VERSION}_ install --full-index

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "bundle _${BUNDLER_VERSION}_ exec bin/rake db:schema:load && bundle _${BUNDLER_VERSION}_ exec bin/rails s -b 0.0.0.0 -p 3000"]


