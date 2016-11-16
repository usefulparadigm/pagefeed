xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @posts.first["from"]["name"]
    xml.link "https://www.facebook.com/#{@posts.first["from"]["id"]}"

    @posts.each do |post|
      xml.item do
        xml.title post["name"]
        xml.link post["permalink_url"]
        xml.description do |desc|
          desc.cdata! <<-DESC
            <img src="#{post["full_picture"]}">
            #{post["message"]}
          DESC
        end
        xml.pubDate Time.parse(post["created_time"]).rfc822
        xml.guid post["id"]
      end
    end
  end
end