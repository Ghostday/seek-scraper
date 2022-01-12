require "byebug"

class Scraper

    @@job_array = []

    def initialize(job, location, page=1)
        url = "https://www.seek.com.au/#{job}-jobs/in-#{location}?page=#{page}"
        puts "fetching from #{url}"
        page = HTTParty.get(url)
        doc = Nokogiri::HTML(page)
        
        articles = doc.css("article")
        puts articles.count
        
        articles.each do |article|
            job_title = article.at_css("h1").text
            job_location = article.at_css("strong").css("a").text
            job_company = article.at_css("a[data-automation='jobCompany']") ? article.at_css("a[data-automation='jobCompany']").text : "Private"
            job_link = "https://www.seek.com.au#{article.at_css("a[data-automation='jobTitle']")['href']}"

            article_desc = article.css("li")
            job_desc = article.css("span[data-automation='jobShortDescription']").text
            if article_desc.count > 0
                job_desc_list = []
                article_desc.each do |desc|
                    job_desc_list.push(desc.text)
                end
            end

            @@job_array << Job.new(job_title, job_location, job_company, [job_desc_list, job_desc], job_link)        
        end

    end
end