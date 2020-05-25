class User < ActiveRecord::Base

    has_many :userlinks
    has_many :links, through: :userlinks

    @@prompt = TTY::Prompt.new

    def self.display_main_menu
        menu_choices = ["Add Link", "Saved Links", "Suggested Links", "Update Link", "Remove Link", "Exit"]

        choice = @@prompt.select("Main Menu", menu_choices)

        case choice
        when "Add Link"
            #add a link
            Link.add_link
        when "Saved Links"
            puts "saved links"
        when "Suggested Links"
            puts "suggested links"
        when "Update Link" 
            puts "update link"
        when "Remove Link"
            puts "remove link"
        when "Exit"
            system('exit')
        end
    end
            
end