# Installation
```
git clone git@github.com:tksasha/fb-metrics.git
```

# Testing
```
cd fb-metrics/

RAILS_ENV=test rake db:migrate

rake
```

# Development
```
cd fb-metrics/

echo "FACEBOOK_ACCESS_TOKEN = ACTUAL_FACEBOOK_ACCESS_TOKEN" > .env

rake db:migrate

rake metrics[www.nike.com,42]
```

# Usage
```
cd fb-metrics/

echo "FACEBOOK_ACCESS_TOKEN = ACTUAL_FACEBOOK_ACCESS_TOKEN" > .env

RAILS_ENV=production rake db:migrate

RAILS_ENV=production rake metrics[www.nike.com,42]
```

# TODO:
- catch errors with redirect because `nike.com` doesn't work only `www.nike.com`;
- make decision with links like `http://www.tksasha.me/companies.html?first=true&second=true` because Facebook store it like `http://www.tksasha.me/companies.html?first=true` (without parameters after ampersand `&`);
- add multithreading or another decision for paraller pages processing (maybe `Sidekiq`);
- catch all possible errors with timeouts or bad data from responces;
- get `Facebook Access Token` from the `Graph API`;

# Note
`Facebook Access Token` is required to prevent `403` error when we send many requests to Facebook.
