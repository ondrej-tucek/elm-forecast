# Elm Forecast Weather App

A simple web app written in Elm (v. 0.18).


### Install:
```
$ git clone git@github.com:ondrej-tucek/elm-forecast.git
$ cd elm-forecast
$ npm install
$ elm-package install -y
```

### Launching app:
```
$ npm start
```

* Access app at `http://localhost:8080/`
* Or live [demo](http://elm-forecast.surge.sh/)

### Changelog
As is noted at [developer.yahoo.com/weather](https://developer.yahoo.com/weather/) website:
> Important EOL Notice: As of Thursday, Jan. 3, 2019, the weather.yahooapis.com and query.yahooapis.com for Yahoo Weather API will be retired.

So, in order to maintain of functionality, data aren't fetched in realtime from yahoo weather as before, but only from static json dataset.

## License
[![MIT](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/ondrej-tucek/elm-forecast/blob/master/LICENSE)
