xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @page["name"]
    # xml.description @page["about"]
    xml.link "https://www.facebook.com/#{@page["id"]}"

    @posts.each do |post|
      xml.item do
        xml.title post["name"]
        xml.link post["permalink_url"]
        xml.description post["message"]
        xml.pubDate Time.parse(post["created_time"]).rfc822
        xml.guid post["id"]
      end
    end
  end
end