# Feederometer

Find out if any of your teammates has been feeding lately and spam the report button right away!

[Live website demo](http://carloseme.xyz/feederometer/) (Example summoner profiles to check: CarlosEME, Steffzor)

# How to run the project

First clone the project `git clone https://github.com/Carlows/feederometer.git`.
Then install the bundles with `bundle install --without production`.
And run the migrations `bundle exec rake db:migrate`.

That's it!

# Technologies used

- Ruby and Ruby on Rails
- JQuery
- Twitter Bootstrap and SASS
- PostgreSQL
- [Riot API](https://developer.riotgames.com/api/methods/)

# Why did you decided to make this?

Well, I though it would be fun to learn Rails so I gave it a try (and it was really fun!). 

The application gets JSON data from the RIOT API and converts it to a hash, to avoid sending to many requests to the api, I used postgres to store the data requested to the database with an expiration time of an hour, if there are more requests made to the same summoner profile, then the data will be requested from the DB instead of sending another request to the API, this way there isn't any overhead on the rate limit.

## Features to add

- Logging exceptions correctly (I just feel blind when an exceptions occurs on production)
- Caching team data just like profile data to avoid sending too many requests
- Full code coverage with unit tests