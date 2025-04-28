FROM docker.io/library/debian:bookworm-slim
WORKDIR /src

RUN apt-get update
RUN apt-get install -y xvfb chromium chromium-driver
RUN apt-get install -y ruby bundler git
RUN gem install watir selenium-webdriver
RUN gem install sinatra rackup
RUN mkdir -p /src
RUN git clone https://github.com/s4wyer/articulate-rise-to-omnisets /src

EXPOSE 4567
CMD ["rackup", "--host", "0.0.0.0", "-p", "4567"]
