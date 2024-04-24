# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# TODO

1. Functional app bar on map dashboard
    * query timeframe etc. should be similar to owntracks frontend
    * show friends traces/locations
2. levels of friends sharing
    * only current location
    * only locations older than 30 days
3. full map features
    * Map should query for data based on its viewport
    * locations bubble with details, edit modal, link to google maps etc
4. Packaging story
    * look at [tebako](https://github.com/tamatebako/tebako)
    * Add full `docker-compose.yml` and publish production image
5. UI for changing password
6. UI for managing friends
7. Tailwind detect dark/lite mode
    * select map tile set based on dark/lite mode settings
8. Mobile UI?
    * I won't use it but people might
9. export
    * export to owntracks, gross but could be useful. IE > 10years old points archived in owntracks format
    * other places to export, IE nextcloud phone tracker etc.
    * proxy pass owntracks payloads to other services ie home assistant
10. TimescaleDB?
    * It might be possible to compress the location data over time as much of it is redundant with timescale
    * look into what maps timeline does? its some how able to push all 1.6 million of my data points in < 2 seconds
