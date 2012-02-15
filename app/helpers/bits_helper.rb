module BitsHelper
  def limit_string( str, lineLimit = 5, charLimit = 1000 )
    lines = str[0,charLimit].split "\n"
    logger.info "lines = " + lines.inspect
    retVal = lines[0..4].join "\n"

    retVal += "\n[...]" if retVal.length < str.length
    return retVal
  end

  def oldTagsJS
    '<script type="text/javascript">' +
    'window.oldTags = [' + @bit.tag_list.map {|t| "'" + t + "'"} .join(',') + "]" +
    '</script>'
  end
end
