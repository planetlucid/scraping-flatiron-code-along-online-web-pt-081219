@@ -1,11 +1,12 @@
require 'nokogiri'
require 'open-uri'

require 'pry'
require_relative './course.rb'

class Scraper
  attr_accessor :doc, :course_info

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
@@ -15,8 +16,30 @@ def print_courses
      end
    end
  end

  def get_page
    html = open("http://flatironschool.com/courses")
    @doc = Nokogiri::HTML(html)
  end

  def get_courses
   @course_info =  get_page.css('.post')


  end

  def make_courses
   get_courses.each do |course|
      c = Course.new
      c.title = course.children.children.first.text
      c.schedule = course.children.children[1].text
      c.description = course.children.children[2].text
      Course.all << c
    end

  end



end