# BSB

A personal feed reader built with EmberJS and Sinatra.

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/) (with NPM)
* [Bower](http://bower.io/)
* [Ember CLI](http://www.ember-cli.com/)
* [PostgreSQL](http://www.postgresql.org/)

## Installation

* `git clone <repository-url>` this repository
* change into the new directory
* `npm install`
* `bower install`
* `bundle install`
* Create postgres user bsb (`createuser bsb`)
* Create postgres database bsb\_development (`createdb bsb_development`)
* `rake db:migrate`

## Running / Development

* `ember build --watch`
* `ruby server.rb`
* Visit your app at [http://localhost:4567](http://localhost:4567).
* Go to [http://localhost:4567/settings](http://localhost:4567/settings) to add RSS feeds

### Building

* `ember build` (development)
* `ember build --environment production` (production)

### Deploying

* Can be deployed to heroku (instructions coming soon)

## Further Reading / Useful Links

* [ember.js](http://emberjs.com/)
* [ember-cli](http://www.ember-cli.com/)
* Development Browser Extensions
  * [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)

