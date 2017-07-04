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

# Usage
```
cd fb-metrics/

rake db:migrate

rake metrics[www.nike.com,42]
```
