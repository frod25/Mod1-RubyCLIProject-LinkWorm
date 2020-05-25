class Link < ActiveRecord::Base

    has_many :userlinks
    has_many :users, through: :userlinks

    @@prompt = TTY::Prompt.new

    def self.add_link
        url = @@prompt.ask("What is the URL of your link?", required: true)
        title = @@prompt.ask("What is the title of your link?", required: true)
        Link.create(url: url, title: title)

        #if its in order of first to last added, we'll want to reverse it
        Link.all.limit(5).each do |link|
            puts link.url
            puts link.title
        end
    end

end