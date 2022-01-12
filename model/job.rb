class Job
    attr_accessor :title, :location, :company, :link
    @@count = 0
    @@jobs = []

    def initialize(title, location, company, description, link)
        @title = title
        @location = location
        @company = company
        @description = description
        @link = link
        
        @@count += 1
        @@jobs << self
    end

    def description
        if @description[0].nil?
            return @description[1]
        end
        if @description[0].count > 0
            return @description[0].join("\n") + "\n" + @description[1]
        end
    end

    def self.list_titles
        @@jobs.each do |job|
            puts "=========================================="
            puts "Title: #{job.title}"
            puts "Company: #{job.company}"
            puts "\n#{job.description}"
            puts ""
            puts "#{job.link}"
            puts "------------------------------------------"
            puts ""
        end
        puts "#{count} jobs scraped"
    end

    def self.count
        @@count
    end

    def self.write_to_csv(filename)
        CSV.open("#{filename}.csv", "w") do |csv|
            @@jobs.each do |job|
                csv << [job.title, job.company, job.description, job.link]
            end
        end
        puts "exporting to #{filename}.csv"
    end
end