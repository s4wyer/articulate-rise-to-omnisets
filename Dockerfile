RUN apt-get update && apt-get install -y xvfb chromium chromium-driver
RUN apt-get install -y ruby bundler git
RUN gem install selenium-webdriver 
RUN gem install watir sinatra
RUN mkdir -p /src  
RUN git clone https://github.com/s4wyer/articulate-rise-to-omnisets /src
