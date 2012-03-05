xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Vimbits"
    xml.description "A vimbit is a snippet of a .vimrc. Share your coolest trick, mapping, setting, or custom command for the Vim editor. Find new bits and vote up the best ones."
    xml.link bits_url + (params[:sort] ? "?sort=" + params[:sort] : '')

    for bit in @bits
      xml.item do
        xml.title bit.title
        xml.description '<pre><code>' + bit.code + '</pre></code>' + '<p>' + @markdown.render(bit.description) + '</p>'
        xml.pubDate bit.created_at.to_s(:rfc822)
        xml.link url_for(bit)
        xml.guid url_for(bit)
      end
    end
  end
end

