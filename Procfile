web: bin/rails server -p $PORT -e $RAILS_ENV

priceworker: bundle exec sidekiq -q default -q mailers -c 2