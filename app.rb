require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'json'
require 'builder'

PAGE_FIELDS = "name,about,username,link,picture{url}"
POST_FIELDS = "description,message,created_time,type,permalink_url,full_picture,updated_time,from"

get '/' do
  erb :index
end

get '/rss' do
  page_id = params[:page_id]
  halt "page_id is required!" unless page_id
  # @page = get_page(page_id)
  @posts = get_page_posts(page_id)
  @page = @posts.first["from"]
  builder :rss if @posts
end


private

# def get_page(page_id)
#   page_url = "https://graph.facebook.com/#{page_id}?access_token=#{access_token}&fields=#{PAGE_FIELDS}"
#   fetch(page_url)
# end

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
