require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    #This method should contain only the code for getting the HTML document
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    #get_courses method should operate on the HTML page (which is the return value of the .get_page method) 
    #and return the collection of Nokogiri XML elements that describe each course.
    self.get_page.css(".post")
  end 

  def make_courses
    #make_courses method should operate on the collection of course offering Nokogiri XML elements 
    #returned by the .get_courses method. The .make_courses method should iterate over the collection 
    #and make a new instance of Course class for each one while assigning it the appropriate attributes
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end 
  


  def print_courses
    #calls on .make_courses and then iterates over all of the courses that get created to puts out a list of course offerings
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


# Scraper.new.get_page 



