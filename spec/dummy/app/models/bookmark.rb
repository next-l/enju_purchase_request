class Bookmark
  def self.get_title_from_url(url)
    return if url.blank?
    return unless Addressable::URI.parse(url).host
    if manifestation_id = url.bookmarkable_id
      manifestation = Manifestation.find(manifestation_id)
      return manifestation.original_title
    end
    unless manifestation
      normalized_url = Addressable::URI.parse(url).normalize.to_s
      doc = Nokogiri::HTML(open(normalized_url))
      # TODO: 日本語以外
      #charsets = ['iso-2022-jp', 'euc-jp', 'shift_jis', 'iso-8859-1']
      #if charsets.include?(page.charset.downcase)
        title = NKF.nkf('-w', CGI.unescapeHTML((doc.at("title").inner_text))).to_s.gsub(/\r\n|\r|\n/, '').gsub(/\s+/, ' ').strip
        if title.blank?
          title = url
        end
      #else
      #  title = (doc/"title").inner_text
      #end
      title
    end
  rescue OpenURI::HTTPError
    # TODO: 404などの場合の処理
    raise "unable to access: #{url}"
  #  nil
  end
end
