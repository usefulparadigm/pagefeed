xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0", :'xmlns:atom' => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title @posts.first["from"]["name"]
    xml.link "https://www.facebook.com/#{@posts.first["from"]["id"]}"
    xml.description "PageFeed on #{@posts.first["from"]["name"]} Facebook Page"
    xml.tag! "atom:link", :href => request.url, :rel => "self", :type => "application/rss+xml"
    @posts.each do |post|
      xml.item do
        xml.title post["name"]
        xml.link post["permalink_url"]
        xml.description do |desc|
          desc.cdata! <<-DESC
            <img src="#{post["full_picture"]}" class="webfeedsFeaturedVisual">
            #{post["message"]}
          DESC
        end
        xml.pubDate Time.parse(post["created_time"]).rfc822
        xml.guid post["id"], :isPermaLink => false
      end
    end
  end
end