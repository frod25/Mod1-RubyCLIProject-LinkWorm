class Interface

    @@prompt = TTY::Prompt.new(help_color: :white)

    def initialize
        self.intro
        self.login_or_register
    end

    def intro
        puts "Welcome to ... ".colorize(:color => :white, :background => :blue)
        sleep(0.5)
        puts "
        ██╗     ██╗███╗   ██╗██╗  ██╗
        ██║     ██║████╗  ██║██║ ██╔╝
        ██║     ██║██╔██╗ ██║█████╔╝ 
        ██║     ██║██║╚██╗██║██╔═██╗ 
        ███████╗██║██║ ╚████║██║  ██╗
        ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
        ".light_blue
        sleep(0.5)
        puts "
        ██╗    ██╗ ██████╗ ██████╗ ███╗   ███╗
        ██║    ██║██╔═══██╗██╔══██╗████╗ ████║
        ██║ █╗ ██║██║   ██║██████╔╝██╔████╔██║
        ██║███╗██║██║   ██║██╔══██╗██║╚██╔╝██║
        ╚███╔███╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║
         ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝
        ".light_blue
        # .colorize(:color => :blue)
        sleep(0.5)
        puts " "
        puts " "
    end

    def self.quit
        self.worm_animation
        sleep(0.5)
        system("clear")
        puts "
         ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗
        ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
        ██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗  
        ██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝  
        ╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗
         ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝".light_blue
        puts " "
        puts " "
        puts "              Thanks for using our app, hope to see you again             ".colorize(:color => :white, :background => :blue)
        system('exit')
    end

    def login_or_register
        selection = @@prompt.select("Would you like to login or register?".colorize(:color => :white, :background => :blue), active_color: :blue) do |m|
            m.choice "Login", -> {self.login}
            m.choice "Register", -> {self.register}
            m.choice "Quit".red, -> {Interface.quit}
        end
    end

    def login_success(user)
        Interface.worm_animation
        system('clear')
        puts "
    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
    ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
                                                              ".light_blue
        puts " "               
        puts " "
        puts "                 Happy to see you, #{user.user_name.capitalize}                    ".colorize(:color => :white, :background => :blue)
        puts " "
        puts " "
            #call class method for User class
            User.display_main_menu(user)
    end

    def login_failed(user)
        puts "Wrong password".red
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
            not_found = @@prompt.select("Username not found..".red, ["Try Again", "Register"])
            not_found == "Try Again" ? self.login : self.register
        end
    
    end

    def register
        new_user_name = @@prompt.ask("Enter a new username:", required: true, modify: :strip)
        if User.find_by(user_name: new_user_name)
            puts "That username is already taken. Try again".red
            self.register
        else
            new_pw = @@prompt.ask("Enter a password:", required: true, modify: :strip)
            new_user = User.create(user_name: new_user_name, password: new_pw)
            self.login_success(new_user)
        end
    end

    def self.worm_animation
        frame0 = "                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                            `.-:///--`                                              
                                       `:shmMMMMMMMMMMNmho:`                                        
                                     :yNMMMMMMMMMMMMMMMMMMMMd+`                                     
                                   :dMMMMMMMMMMMMMMMMMMMMMMMMMNs`                                   
                                 .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs`                                 
                                /NMMMMMMMMMMMMNdyyyydmMMMMMMMMMMMMm:                                
                              .hMMMMMMMMMMMh/.        .+dMMMMMMMMMMMy.                              
                            `sMMMMMMMMMMMy-              -hMMMMMMMMMMN+`                            
               `..`      ./yNMMMMMMMMMMd-                  :dMMMMMMMMMMNs:.`                        
             `yMMMMNNNNNNMMMMMMMMMMMMNo`                     /NMMMMMMMMMMMMNmho-                    
             /MMMMMMMMMMMMMMMMMMMMMMh.                        `sMMMMMMMMMMMmsMMMh`                  
             .mMMMMMMMMMMMMMMMMMMNs-                            -yMMMMMMMMMNdMMMM.                  
              `+hNMMMMMMMMMMMMms:`                                `+hNMMMMMMMMMMs                   
                  .:/+osyso+:`                                       `-+syyyys/`                    
                                                                                                    
                                                                                                    
        ".light_blue

        frame1 = "                                                                                                    
                                                                                                            
                                                                                                    
                                                                                                    
                                           `/sddddy+.                                               
                                         .yMMMMMMMMMMy`                                             
                                        -NMMMMMMMMMMMMm-                                            
                                       .mMMMMMMMMMMMMMMN-                                           
                                       sMMMMMMMMMMMMMMMMd`                                          
                                      `mMMMMMMMmhMMMMMMMMo                                          
                                      -MMMMMMMMo`mMMMMMMMm`                                         
                                      +MMMMMMMM: sMMMMMMMM.                                         
                                     `dMMMMMMMM  -MMMMMMMMh`                                        
                        `-:-`       .yMMMMMMMMd  `mMMMMMMMMm+-....`                                 
                       sMMMMMNdyyyhdMMMMMMMMMM:   /MMMMMMMMMMMMMMMNy`                               
                      `NMMMMMMMMMMMMMMMMMMMMN/     +MMMMMMMMMMModMMMs                               
                       /NMMMMMMMMMMMMMMMMMMd-       -hMMMMMMMMMMMMMMs                               
                        .ohNMMMMMMMMMMMMms-           `+ymNMMMMMMNd+                                
                            `..----::-.                    .-::-.`                                  
                                                                                                    
                                                                                                    
        ".light_blue
            
        frame2 = "
                                                                                                            
                                                                                                    
                                                                                                    
                                                                                                    
                                            `.-:///--`                                              
                                       `:shmMMMMMMMMMMNmho:`                                        
                                     :yNMMMMMMMMMMMMMMMMMMMMd+`                                     
                                   :dMMMMMMMMMMMMMMMMMMMMMMMMMNs`                                   
                                 .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs`                                 
                                /NMMMMMMMMMMMMNdyyyydmMMMMMMMMMMMMm:                                
                              .hMMMMMMMMMMMh/.        .+dMMMMMMMMMMMy.                              
                            `sMMMMMMMMMMMy-              -hMMMMMMMMMMN+`                            
               `..`      ./yNMMMMMMMMMMd-                  :dMMMMMMMMMMNs:.`                        
             `yMMMMNNNNNNMMMMMMMMMMMMNo`                     /NMMMMMMMMMMMMNmho-                    
             /MMMMMMMMMMMMMMMMMMMMMMh.                        `sMMMMMMMMMMMmsMMMh`                  
             .mMMMMMMMMMMMMMMMMMMNs-                            -yMMMMMMMMMNdMMMM.                  
              `+hNMMMMMMMMMMMMms:`                                `+hNMMMMMMMMMMs                   
                  .:/+osyso+:`                                       `-+syyyys/`                    
                                                                                                    
                                                                                                    
        ".light_blue

        frame3 = "
                                                                                                            
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                          ``-:/oo++/::.`                                            
                                    `-+sdmNMMMMMMMMMMMMNmho:`                                       
                                 .+hNMMMMMMMMMMMMMMMMMMMMMMMMms/.                                   
                              `+dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNho/.`                             
              .-:/++//:---:/odNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmy+/-.`                      
           `sNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmddhhdNMMMMMMMMMMMMMMMMMMMMMMMNNdy+.                 
           dMMMMMMMMMMMMMMMMMMMMMMMMMMMNho/-`         `-+ymMMMMMMMMMMMMMMMMMMMhdMMMo                
           yMMMMMMMMMMMMMMMMMMMMMMMmo:.                    `:sdMMMMMMMMMMMMMMMmmMMMd                
            /hmNMMMMMMMMMMMMMMNds/.                            `-/sdNMMMMMMMMMMMMMm-                
                .-:++oooo++/-.                                       -/oshhddhhys:                  
                                                                                                                                                                                                
        
        ".light_blue

        frame4 = "
        
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
             .:::----...``````````                                ````.--:///:.                     
           /mMMMMMMMMMMMMMMMMMMMMNNmmmmddhyyyyyyyyyyyyyyhhhhhhhdmNMMMMMMMMMMMMMms`                  
          .NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh:MMMMm                  
          .NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                 
           -hMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh-                  
             `-+yhNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmdyo/.                    
                     ``.---:://////++++ooooooosssossooooooooooo++++/:--.`                           
                                                                                                    
        
        ".light_blue

        frame5 = "
                                                                                                            
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                          ``-:/oo++/::.`                                            
                                    `-+sdmNMMMMMMMMMMMMNmho:`                                       
                                 .+hNMMMMMMMMMMMMMMMMMMMMMMMMms/.                                   
                              `+dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNho/.`                             
              .-:/++//:---:/odNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmy+/-.`                      
           `sNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmddhhdNMMMMMMMMMMMMMMMMMMMMMMMNNdy+.                 
           dMMMMMMMMMMMMMMMMMMMMMMMMMMMNho/-`         `-+ymMMMMMMMMMMMMMMMMMMMhdMMMo                
           yMMMMMMMMMMMMMMMMMMMMMMMmo:.                    `:sdMMMMMMMMMMMMMMMmmMMMd                
            /hmNMMMMMMMMMMMMMMNds/.                            `-/sdNMMMMMMMMMMMMMm-                
                .-:++oooo++/-.                                       -/oshhddhhys:                  
                                                                                                   
        
        ".light_blue

        animation_array = [frame0, frame1, frame2, frame3, frame4, frame5]

        3.times do
            i = 1
            while i < 5
                animation_array.each do |frame|
                    puts frame
                    sleep(0.1)
                    system("clear")
                    i += 1
                end
                system("clear")
            end
        end
    end

end