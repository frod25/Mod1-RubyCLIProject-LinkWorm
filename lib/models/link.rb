class Link < ActiveRecord::Base

    has_many :user_links
    has_many :users, through: :user_links

    @@prompt = TTY::Prompt.new

    def self.add_link(user)
        url = @@prompt.ask("What is the URL of your link?", required: true)
        title = @@prompt.ask("What is the title of your link?", required: true)
        visited = @@prompt.yes?("Mark as visited?", required: true)
        favorite = @@prompt.yes?("Save to favorites?", required: true)

        new_link = self.create(url: url, title: title)
        UserLink.create(user_id: user.id, link_id: new_link.id, visited: visited, is_favorite: favorite)

        puts "Success!.. Your link was added to the database."
        User.display_main_menu(user)
    end


    def self.suggested_links(user)
        puts " "
        puts "These are the most popular websites!".colorize(:color => :white, :background => :blue)
        puts "Google.com"
        puts "Youtube.com"
        puts "Reddit.com"
        puts "Facebook.com"
        puts "Twitter.com"
        puts "news.ycombinator.com"
        puts "Leetcode.com"
        User.display_main_menu(user)
        return nil
    end

end