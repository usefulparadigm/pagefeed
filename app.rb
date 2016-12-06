require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'json'
require 'builder'

PAGE_FIELDS = "name,about,username,link,picture{url}"
POST_FIELDS = "name,message,description,created_time,type,permalink_url,full_picture,updated_time,from"

# https://www.facebook.com/help/105399436216001?helpref=faq_content
# Usernames can only contain alphanumeric characters (A-Z, 0-9) or a period (".").
PAGE_URL_REGEX = /(https?:\/\/)?(www\.)?facebook\.com\/([a-zA-Z0-9.]+)\/?/



get '/' do
  erb :index
end

get '/rss' do
  # preserving page_id for backward compatibility
  page_id = params[:page_id].to_s
  if page_id.empty?
    page_url = params[:page_url].to_s
    halt "page_url is required!" if page_url.empty?
    page_id = get_page_id(page_url)
  end  
  if page_id && !page_id.empty?
    @posts = get_page_posts(page_id)
    builder :rss if @posts
  else
    halt "Invalid Page URL. Try again!"
  end
end


private

def get_page_id(url)
  $3 if url =~ PAGE_URL_REGEX
end

def get_page_posts(page_id)
  feed_url = "https://graph.facebook.com/#{page_id}/posts?access_token=#{access_token}&fields=#{POST_FIELDS}"
  result = fetch(feed_url)
  halt result["error"]["message"] if result["error"]
  result["data"]  
end

def fetch(url)
  res = Net::HTTP.get URI(url) rescue nil
  JSON.parse(res) if res
end

def access_token
  ENV["FACEBOOK_ACCESS_TOKEN"] || %Q(#{ENV["FACEBOOK_APP_ID"]}|#{ENV["FACEBOOK_APP_SECRET"]})
end
