FROM ruby:3.0.1
ADD . /frank_calendar_docker
WORKDIR /frank_calendar_docker
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
