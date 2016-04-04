-----

This is a prototype for a tutor-hiring webapp.

The idea is to hire quality tutors at a lower rate than other platforms.

-----

## Basic stuff

**Ruby version**: 2.3.0 and up (uses the `&.` "[safe navigation operator](http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/)" and Rails 5)

**System dependencies**: Postgres

**Configuration**: Add Braintree credentials (see [config/application.yml.example](config/application.yml.example), used by [figaro](https://github.com/laserlemon/figaro))

**Start app**: `rake db:create db:migrate; PING=true rails s` and open `localhost:3000`

**Test suite**: there isn't one :sweat_smile:

-----

## More detailed info

##### Database tables

  1. `users`
  2. `messages` are used for all communication between users.
  3. `payment_requests` are made when one user wants to hire another.
  4. `payments` are made when `payment_requests` are accepted.
  5. `tickers` are background processes

##### Background processes

  - Instead of something like Resque, I'm using a backgrounding system I wrote.
  - See [app/models/ticker.rb](app/models/ticker.rb) for the base class and [config/initializers/user_pings.rb](config/initializers/user_pings.rb) for a usage example.
  - This background process system can also be seen in my [tickers](https://github.com/maxpleaner/tickers) project or on my codereview.stackexchange.com post [here](codereview.stackexchange.com/questions/122159/a-two-method-program-for-running-background-jobs)

##### Websockets / realtime

This is a Rails 5 app, so ActionCable is built in. However, I opted to use [websocket-rails](https://github.com/websocket-rails/websocket-rails/) and the wrapper gem I wrote around it, [socket_helpers](https://github.com/maxpleaner/socket_helpers)

There are two realtime components to the app

  1. The list of online users
  2. The unread messages section.

Notifications about payment requests are sent to the unread messages section.

##### How does the online users component work
    
1. There's standard auth to set the `session_token` on users when they login
2. Javascript pings the server every 5 seconds (until the browser tab is closed)
3. A background process runs every 10 seconds and signs out any users which have stopped pinging.
4. websocket updates are pushed whenever a user signs in or out.

##### what does the `PING=true` command line argument do

when starting the server with `PING=true rails server` as opposed to just `rails server`, two things happen:

  1. The background job ([config/initializers/user_pings.rb](config/initializers/user_pings.rb)) starts
  2. The Javascript pinging client is activated (each client will ping the server every 5 seconds) 

This can be annoying in development, which is why it can be disabled by ommitting the command line argument.

##### Important files

  - [app/assets/javascripts/application.js.erb](app/assets/javascripts/application.js.erb)
  - app/assets/javascripts/braintree.js (the braintree Javascript SDK, minified)
  - [app/assets/stylesheets/application.css.scss.erb](app/assets/stylesheets/application.css.scss.erb)
  - app/assets/stylesheets/bootstrap.css (Bootstrap CSS, minified)
  - [app/controllers/application_controller.rb](app/controllers/application_controller.rb)
  - [app/controllers/pages_controller.rb](app/controllers/pages_controller.rb) (**all of the app's controller actions are here**)
  - everything in [app/models/](app/models/)
  - everything in [app/views/](app/views/)
  - [config/initializers/braintree.rb](config/initializers/braintree.rb)
  - [config/initializers/user_pings.rb](config/initializers/user_pings.rb)
  - [config/application.yml.example](config/application.yml.example) (set braintree credentials here and rename the file)
  - [config/routes.rb](config/routes.rb)
  - the migrations in [db/migrate](db/migrate/)
  - [Gemfile](Gemfile)

##### Deployment

- Haven't yet tried this, though I've had success using this websocket & background job technique on Heroku.

##### Contributions

Please, please. Needs: _style_, _access control checks_, _emails_, _etc_, _etc_, _etc_ 