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
