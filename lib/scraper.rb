require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) #identifies the page to be scraped
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post| #pulls all the course listings using their class name: post
      course = Course.new #creates a new instance of the Course class for each course on the site
      course.title = post.css("h2").text #uses the Course class' #title setter method to set the value of the instance's title equal to the course's title from the site | use CSS/HTML tags to select right site elements
      course.schedule = post.css(".date").text #uses Course class' #schedule setter method to set value of instance's schedule equal to course's schedule from site
      course.description = post.css("p").text #uses Course class' #description setter method to set value of instance's description equal to course's descripton from the site
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses 



