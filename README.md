# AppLogger

Minimal Web Analytics provider.

In other words, syslog drainer (works with Heroku) that stores logs in a PostgreSQL DB, transforms them into aggregatable information and displays them in a friendly manner.

The goal is to build something simple yet useful.

# How it works

## Logging data
In your application, log the following line while processing your request:

LOG_LINE_KEY=JSON_ENCODED_DATA

LOG_LINE_KEY is a uniquely identifiable string that will be used to pick or ignore log lines from being processed. Configurable via the LOG_LINE_KEY env var.

JSON_ENCODED_DATA is a JSON string that contains the following keys:

|Key|Description|Example|Required|
|---|-----------|-------|--------|
|path|Requested path|/index|yes|
|referrer|Value of the referrer header|https://myblog.com/|no|
|query_string|Value of the query params|utm_source=Facebook&igshid=1234ABCD|no|
|http_method|HTTP Verb of the request|GET|yes|
|format|MIME type of the request|text/html|yes|
|ip|Remote IP|182.22.98.233|yes|
|user_agent|User agent|Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36|yes|

## Extraction
This app provides an HTTP POST endpoint to feed logs into the logger (POST /logs).

HTTP header `Logplex-Msg-Count` must be set with the amount of messages sent in the body of the request, see [Heroku's docs](https://devcenter.heroku.com/articles/log-drains#https-drains).

Logs are parsed  according to [RFC5424](https://datatracker.ietf.org/doc/html/rfc5424).

Once parsed they are stored in the logs table, and enqueued to be transformed in the background.

## Transformers

Transformation process is run in background jobs, via Sidekiq.

Current transformations are:
  - IP to country code
  - ...

Logs that do not contain transformable information are removed.

## Visualization

Once the logs are transformed, they are displayed in the Dashboard page.

It uses chart.js for the line chart, and GeoChart from Google Charts for the country chart.

Basic filters are in place, although they need to be improved.

## Authorization
HTTP Basic Auth is used to protect all endpoints.

Set the env vars HTTP_BASIC_AUTH_NAME and HTTP_BASIC_AUTH_PASSWORD with your desired credentials.

# Contributing

## Development
1. Install ruby (2.7.x preferred), `gem install bundler` and `bundle install`.
2. Create the database `bundle exec rails db:create db:migrate`.
3. Populate some data with `bundle exec rails runner 'FactoryBot.create_list(:entry, 1000)'`.
4. Copy the .env.dist file and update with your data `cp .env.dist .env`
5. Download the GeoLite2 Country database from your MaxMind's account and set the following env vars:
    - GEOIP_GEOLITE2_PATH the path to your downloaded MaxMind database
    - GEOIP_GEOLITE2_COUNTRY_FILENAME the file name of the downloaded MaxMind database
6. Run the server `bundle exec rails s`

## Testing
1. Follow first two steps from the Development section
2. Copy the .env.test file `cp .env.test .env.test.local`
3. Set the GeoLite2 env vars in the .env.test.local file the same way as in the previous Development section
4. Run the specs `bundle exec rspec`

## Deployment to Heroku
1. Add the buildpack https://github.com/danstiner/heroku-buildpack-geoip-geolite2 to download MaxMind's database at deploy time.
2. Get a MaxMind license key and set the env var `MAXMIND_LICENSE_KEY` with the license key.
3. Set the env vars from .env.dist in your Heroku app — no need to set the GeoLite2 env vars as they are automatically set by the buildpack previously installed.
4. The rest is a normal heroky deploy `git push heroku master`

Once the app is deployed, add it as a log drainer for the web app you want. In Heroku it's done with:

```
heroku drains:add https://HTTP_BASIC_AUTH_NAME:HTTP_BASIC_AUTH_PASSWORD@APPLOGGER_DOMAIN/logs -a NAME_OF_YOUR_APP
```

Make sure to replace HTTP_BASIC_AUTH_NAME, HTTP_BASIC_AUTH_PASSWORD and APPLOGGER_DOMAIN with the correct values.
