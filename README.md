# Feederometer

Find out if any of your teammates has been feeding lately and spam the report button right away!

[Live website demo](http://carloseme.xyz/feederometer/) (Example summoner profiles to check: CarlosEME, Steffzor)

## How to run the project

First clone the project `git clone https://github.com/Carlows/feederometer.git`.
Then install the bundles with `bundle install --without production`.
And run the migrations `bundle exec rake db:migrate`.

That's it!

## Technologies used

- Ruby and Ruby on Rails
- JQuery
- Twitter Bootstrap and SASS
- PostgreSQL
- [Riot API](https://developer.riotgames.com/api/methods/)

## Why did you decide to make this?

Well, I though it would be fun to learn Rails so I gave it a try (and it was really fun!). 

The application gets JSON data from the RIOT API and converts it to a hash, to avoid sending to many requests to the api, I used postgres to store the data requested to the database with an expiration time of an hour, if there are more requests made to the same summoner profile, then the data will be requested from the DB instead of sending another request to the API, this way there isn't any overhead on the rate limit.

## Features to add

- Logging exceptions correctly (I just feel blind when an exception occurs on production)
- Caching team data just like profile data to avoid sending too many requests
- Full code coverage with unit tests

## Interface

### Home

![home](/public/home.png)

The app works like this, when you enter a summoner name, if first checks if that summoner is currently in a game. If he is, then it renders team data:

![team data](/public/team.png)

![team data 2](/public/team2.png)

When a player has more than 60% (that means, 4 or more games feeding) the app renders a different color and message. 

When it can't find the summoner name specified in a game, then it renders a summoner profile:

![profile data](/public/profile.png)

![profile data 2](/public/profile2.png)

