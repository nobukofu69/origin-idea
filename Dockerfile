# Ruby 3.1.2の公式イメージをベースにする
FROM ruby:3.1.2

# Bundler version 2.3.7で失敗するので、gemのバージョンを追記
ARG RUBYGEMS_VERSION=3.3.20

# ディレクトリの作成
RUN mkdir /myapp

# 作業ディレクトリの設定
WORKDIR /myapp

# ホストのGemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundlerの実行
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle config set path 'vendor/bundle' && \
    bundle install