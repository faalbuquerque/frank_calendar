FROM ruby:3.0.1
ADD . /frank_calendar
WORKDIR /frank_calendar
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
