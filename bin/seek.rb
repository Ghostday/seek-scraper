require_relative "../config.rb"

version = 0.2
command = ARGV[0].to_s
ARGV.clear


def options
    puts "What would you like to do?"
    puts "Options Include: more, export, quit"
end

if command == "start"
    running = true
    page = 1
    while running do
        puts "Starting Seek Scraper V#{version}"
        puts "What sort of job are you looking for? (type quit to Exit)"
        search_term = gets.chomp.to_s

        if search_term == "quit" then
            exit 1
        end

        puts "What location are you looking in?"
        search_location = gets.chomp.to_s

        Scraper.new(search_term.gsub(" ", "-"), search_location.gsub(" ", "-"))
        Job.list_titles   
        
        options
        option = gets.chomp.to_s
        while option != "quit"
            if option == "more"
                Scraper.new(search_term.gsub(" ", "-"), search_location.gsub(" ", "-"), page += 1)
                Job.list_titles
            elsif option == "export"
                puts "What filename would you like to export to? (Example: 'data' would export as data.csv)"
                filename = gets.chomp.to_s
                Job.write_to_csv(filename)
            elsif option == "quit"
                exit 1
            end
            options
            option = gets.chomp.to_s
        end
    end
end
