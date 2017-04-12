PageFeed
==

Why?
--
[Facebook deprecated their Page RSS feeds on the 23rd of June 2015](https://developers.facebook.com/docs/apps/changelog#v2_3_90_day_deprecations).
But we need it sometimes. 

How To Use?
--
You can clone this app and deploy it to any hosting platform that support ruby!

Deploying to [Heroku](https://www.heroku.com)
--

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


1. Clone this repo.
2. Create a new Facebook App from [Facebook for Developers](https://developers.facebook.com/apps) and get the App Id and App Secret code.
3. Create a new Heroku app and deploy.
4. Add your Facebook App's credential to Heroku app: `$ heroku config:set FACEBOOK_APP_ID=[Your Facebook App Id] FACEBOOK_APP_SECRET=[Your Facebook App Secret]`
5. Done!


Reference
--

* [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby-o)

License
--

MIT.