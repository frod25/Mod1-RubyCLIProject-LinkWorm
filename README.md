# LinkWorm :bug:

**LinkWorm** is a CLI app that allows you to save links, view all links you've saved, select favorites and mark the ones you've visited. All links are stored in your own private repository. Built using Ruby and countless Gems.

![How to run](https://i.imgur.com/7FVvIvx.png)

## First things first:

1. Clone this repository onto your local machine using `git clone`.
2. Run `bundle install` in your terminal to download all the necessary gems.
3. Run `rake db:migrate` to create the database.
4. Run `rake db:seed` to seed the database automatically.
5. Last, but definitely not least, run `ruby bin/run.rb` to start the app. Enjoy!

**Quick Note** \*If having trouble running 'rake' commands, use **bundle exec rake**\*

## Main Menu

- Add a Link  :bug:
  - Enter a new link into your private repository or make it public to share with others
- View Links  :bug:
  - View all your saved links, favorite links, and links you've visited
- Suggested Links  :bug:
  - See popular links from around the web
- Public Links  :bug:
  - See a list of public links added by other users
  - Save a link to your private repo
- Update Link  :bug:
  - Mark a link as favorite or visited
- Remove Link  :bug:
  - Delete a link from your private repository
- Exit :disappointed:
  - We're sad to see you go.

## Built With

Couldn't have done it without these gems:

- [Faker Gem](https://github.com/faker-ruby/faker): generates fake data to seed
- [TTY::Prompt Gem](https://github.com/piotrmurach/tty-prompt): prompt for command line interface
- [Colorize Gem](https://github.com/fazibear/colorize): enables you to add color to outputted text
- [Text to ASCII Art Generator](http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20): converts text to ASCII art

### Thanks for checking out LinkWorm! :bug:

Made with :heart: by [Senada Kadric](https://github.com/senadakadric) and [Felix Rodriguez](https://github.com/frod25).
