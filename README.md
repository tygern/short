# Short

A simple url shortener

# Instructions

- Set `DATABASE_URL` to your local mysql database.

        export DATABASE_URL = mysql://root:password@localhost/short

- Run migrations

        chmod +x script/db_setup.sh
        script/db_setup.sh

- Run sinatra app

        rackup config.ru -p 3000

- Visit __short__ at localhost:3000