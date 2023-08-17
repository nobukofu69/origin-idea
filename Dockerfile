FROM ubuntu:20.04

# タイムゾーンの設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libreadline-dev \
    libpq-dev zlib1g-dev nodejs npm libmysqlclient-dev  \
    mysql-client curl git wget less && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# sassのインストール
RUN yarn global add sass

# rbenvとruby-buildをインストールしてRubyをインストール
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    ~/.rbenv/bin/rbenv install 3.1.2 && \
    ~/.rbenv/bin/rbenv global 3.1.2

# bundlerをインストール
RUN /root/.rbenv/shims/gem install bundler

# rbenvとgemのパスを通す
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
ENV PATH /path/to/your/app/vendor/bundle/ruby/3.1.0/bin:$PATH

# 作業ディレクトリの設定
WORKDIR /myapp

# ホストのGemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundlerの実行
RUN bundle config --local set path 'vendor/bundle' && \
    bundle install