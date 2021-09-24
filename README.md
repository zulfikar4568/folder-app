## Build Application
```
sudo docker-compose build
sudo docker-compose up
```

## Open second terminal and Migrate your database
```
sudo docker exec -t -i folder-app_web_1 /bin/sh
rails db:create
rails db:migrate

or

docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

## Create Role
```
docker-compose run web rails db:seed
```
## Sign up
When you sign up default role is Guest, so for initialize you can change first account to Admin role.

## Change Role to Admin
```
rails c
Account.all
Account.find_by(id: 2).update(role_id: 6)
```