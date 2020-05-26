class Interface

    @@prompt = TTY::Prompt.new

    def initialize
        self.intro
        self.login_or_register
    end

    def intro
        puts "Hello, this is our app"
    end

    def self.quit
        sleep(0.5)
        system("clear")
        puts "Thanks for using our app, hope to see you again"
        system('exit')
    end

    def login_or_register
        selection = @@prompt.select("Would you like to login or register?") do |m|
            m.choice "Login", -> {self.login}
            m.choice "Register", -> {self.register}
            m.choice "Quit", -> {Interface.quit}
        end
    end

    def login_success(user)
        puts "Welcome Back! Happy to see you again, #{user.user_name}"
            #call class method for User class
            User.display_main_menu(user)
    end

    def login_failed(user)
        puts "Wrong password"
        self.check_pw(user)
    end

    def check_pw(user)
        pw = @@prompt.mask("Enter your password:")
        pw == user.password ? self.login_success(user) : self.login_failed(user)
    end

    def login
        username = @@prompt.ask("Enter your username:", required: true)
        if user = User.find_by(user_name: username)
            self.check_pw(user)
        else
            not_found = @@prompt.select("Username not found..", ["Try Again", "Register"])
            not_found == "Try Again" ? self.login : self.register
        end
    
    end

    def register
        new_user_name = @@prompt.ask("Enter a new username:", required: true, modify: :strip)
        if User.find_by(user_name: new_user_name)
            puts "That username is already taken. Try again"
            self.register
        else
            new_pw = @@prompt.ask("Enter a password:", required: true, modify: :strip)
            new_user = User.create(user_name: new_user_name, password: new_pw)
            User.display_main_menu(new_user)
        end
    end

end