class Link < ActiveRecord::Base

    has_many :user_links
    has_many :users, through: :user_links

    @@prompt = TTY::Prompt.new

    def self.add_link(user)
        url = @@prompt.ask("What is the URL of your link?", required: true)
        title = @@prompt.ask("What is the title of your link?", required: true)
        # visited = @@prompt.yes?("Mark as visited?", required: true)
        # favorite = @@prompt.yes?("Save to favorites?", required: true)
        is_private = false
        is_private = @@prompt.yes?("Mark as private?", required: true)

        new_link = self.create(url: url, title: title, is_private: is_private)
        new_link.save
        
        # UserLink.create(user_id: user.id, link_id: new_link.id, visited: visited, is_favorite: favorite)
        user.links << new_link

        puts "Success!.. Your link was added to the database.".green
        User.display_main_menu(user)
    end


    def self.suggested_links(user)
        puts " "
        puts "These are the most popular websites!".colorize(:color => :white, :background => :blue)
        sugg_links = ["Google.com", "Youtube.com", "Reddit.com", "Facebook.com", "Twitter.com", "news.ycombinator.com", "Leetcode.com"]
        sugg_links.each {|link| puts link}
        User.display_main_menu(user)
    end

    def self.get_public_links
        self.all.where('is_private == ?', false)
    end
    
    def self.display_public_links(user)
        @@prompt.select("Public Link Repository".colorize(:color => :white, :background => :blue), active_color: :blue, per_page: 5) do |m|
            self.get_public_links.each do |public_link|
                m.choice public_link.url, -> {self.link_select_options(user, public_link)}
            end
            m.choice "Main Menu".light_blue, -> {User.display_main_menu(user)}
            m.choice "Exit".red, -> {Interface.quit}
        end
    end

    def self.save_link_to_user(user, link)
        if user.links.include?(link)
            puts "Link already saved...".red
        else
            # UserLink.create(user_id: user.id, link_id: link.id) refactored below
            user.links << link
            puts "Link successfully added to your repo".green
        end
        User.display_main_menu(user)
    end

    def self.link_select_options(user, link)
        puts " "
        @@prompt.select("Options".colorize(:color => :white, :background => :blue), active_color: :blue) do |m|
            m.choice "Save Link", -> {self.save_link_to_user(user, link)}
            m.choice "Main Menu", -> {User.display_main_menu(user)}
            m.choice "Exit".red, -> {Interface.quit}
        end
    end
end