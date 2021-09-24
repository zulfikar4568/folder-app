# Local Deployment
## 1. Build Application
```
sudo docker-compose build
sudo docker-compose up
```

## 2. Open second terminal and Migrate your database
```
sudo docker exec -t -i folder-app_web_1 /bin/sh
rails db:create
rails db:migrate

or

docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

## 3. Create Role
```
docker-compose run web rails db:seed
```
## 4. Sign up
When you sign up default role is Guest, so for initialize you can change first account to Admin role.

## 5. Change Role to Admin
```
rails c
Account.all
Account.find_by(id: 2).update(role_id: 6)
```
# Heroku Deployment

## 1. Heroku Platform
Make sure you have already account Heroku, if not, please register first, install heroku CLI please refer to this link `https://devcenter.heroku.com/articles/heroku-cli`. I used Ubuntu 20.04

```
sudo snap install --classic heroku
```

## 2. Login
Login account heroku and container login heroku
```
heroku login

heroku create

heroku container:login --app your.apps
```
## 3. Deploy Application
Setup addons in heroku
```
 heroku addons:create heroku-postgresql:hobby-dev --app your.app
```
And open your postgre addons and see config in Settings <br/>
Setting your environment Variable 
```
USER=jfdsf435fdsf
PASS=d612f978e7648bfdasf435fasd34sa4
HOST=ec2-18-324.compute-1.amazonaws.com
```
Change syntax in config/environment.rb, config/production.rb, config/test.rb
```
config.hosts << "your.apps.herokuapp.com"
```

Change script docker in Dockerfile
```
COPY Gemfile Gemfile.lock package.json yarn.lock ./

to 

COPY . ./ 
```

Upload and Release Container Registery to your Application
```
heroku container:push web --app your.apps
heroku container:release web --app your.apps
```

## 4. Migrate your Database
Check your container status
```
heroku ps --app your.apps
```

Migrate your Database, open web and klik pending migration
```
heroku open web --app your.app
```

Create role 
```
heroku run bash web --app your.apps

rails db:seed

rails c
Role.all
```