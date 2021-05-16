# AppLogger

Minimal syslog drainer (works with Heroku) that stores logs in a PostgreSQL DB, [TODO] transforms them into aggregatable information and [TODO] display them in a friendly manner.

The goal is to build something simple yet useful.

## Extraction
- Provides an HTTP POST endpoint to feed logs into the logger.
- HTTP header `Logplex-Msg-Count` must be set with the amount of messages sent in the body of the request, see [Heroku's docs](https://devcenter.heroku.com/articles/log-drains#https-drains).
- Auth using Basic Authentication
- Parses logs according to [RFC5424](https://datatracker.ietf.org/doc/html/rfc5424).

## Transformers

TODO:
- [ ] Set up a background runner
- [x] IP into country code.
- [ ] User agent into device.

## Visualization

TODO:
- [x] Tailwind
- [ ] Filters
- [ ] Search
- [ ] Graphs

## Deployment to Heroku
1. Add the buildpack https://github.com/danstiner/heroku-buildpack-geoip-geolite2 to be able to use MaxMind's Geolite2 DB. This is used to convert IP values into country codes.
2. Get a MaxMind license key and set the env var `MAXMIND_LICENSE_KEY` with the license key.
3. The rest is a normal heroky deploy `git push heroku master`
