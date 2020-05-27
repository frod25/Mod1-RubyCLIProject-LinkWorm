class User < ActiveRecord::Base

    has_many :user_links
    has_many :links, through: :user_links

    @@prompt = TTY::Prompt.new

    def self.display_main_menu(user)
        puts " "
         @@prompt.select("Main Menu".colorize(:color => :white, :background => :blue), active_color: :blue) do |m|
            m.choice "Add Link", -> {Link.add_link(user)}
            m.choice "View Links", -> {user.view_links}
            m.choice "Suggested Links", -> {Link.suggested_links(user)}
            m.choice "Update Link", -> {user.update_link}
            m.choice "Remove Link", -> {user.remove_link}
            m.choice "Exit".red, -> {Interface.quit}
        end
    end

    def view_links
        @@prompt.select("Options:".colorize(:color => :white, :background => :blue), active_color: :blue) do |m|
            m.choice "Saved Links", -> {self.get_saved_links}
            m.choice "Favorite Links", -> {self.get_favorite_links}
            m.choice "Visited Links", -> {self.get_visited_links}
        end
    end

    def get_saved_links
        puts " "
        puts "Saved Links:".colorize(:color => :white, :background => :blue)
        self.links.where("url == url").each do |link|
            puts "#{link.title} - #{link.url}"
        end
        User.display_main_menu(self)
        nil
    end

    def get_favorite_links
        puts " "
        puts "Favorite Links:".colorize(:color => :white, :background => :blue)
        self.links.where('is_favorite == ?', true).each do |link|
            puts "#{link.title} - #{link.url}"
        end
        User.display_main_menu(self)
        nil
    end

    def get_visited_links
        puts " "
        puts "Visted Links:".colorize(:color => :white, :background => :blue)
        self.links.where('visited == ?', true).each do |link|
            puts "#{link.title} - #{link.url}"
        end
        User.display_main_menu(self)
        nil
    end

    def update_link
        user_link = nil
        user_link = self.find_userlink_by_url
        if user_link
            self.choose_update_option(user_link)
        else
            return nil
        end  
    end
    

    def find_userlink_by_url
        link_url = nil
        link_url = @@prompt.ask("Link url:", required: true)
        found_link = self.links.find {|link| link.url == link_url}
        
        if found_link 
            userlink = self.user_links.where("link_id == ?", found_link.id)
            return userlink[0] 
        else
            puts " "
            puts "Link not found... going back to main menu".red
            sleep(0.5)
            User.display_main_menu(self)
            return nil
        end
    end

    def choose_update_option(userlink)
        puts " "
        @@prompt.select("Select Option:".colorize(:color => :white, :background => :blue), active_color: :blue) do |m|
            m.choice "Mark as favorite", -> {self.mark_as_fav(userlink)}
            m.choice "Mark as visited", -> {self.mark_as_visited(userlink)}
        end
        
    end

    def mark_as_fav(userlink)
        userlink.is_favorite = true
        userlink.save
        puts " "
        puts "Awesome! This link has now been marked as favorite.".green
        User.display_main_menu(self)
        nil
    end

    def mark_as_visited(userlink)
        userlink.visited = true
        userlink.save
        puts " "
        puts "Awesome! Link marked as visited.".green
        User.display_main_menu(self)
        nil
    end

    def remove_link
        link_to_remove = self.find_userlink_by_url
        if link_to_remove
            if @@prompt.yes?("Are you sure?".colorize(:color => :white, :background => :red))
                link_to_remove.destroy
                puts " "
                puts "Link has been removed from database!".green
                User.display_main_menu(self)
                nil
            else
                puts " "
                puts "Removal aborted. Taking you back to the main menu".red
                User.display_main_menu(self)
                nil
            end
        end
    end
            
end
