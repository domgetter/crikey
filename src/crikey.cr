require "./crikey/*"

module Crikey
	AUTO_CLOSING_TAGS = [:area, :base, :br, :col, :command, :embed, :hr, :img, :input, :keygen, :link, :menuitem, :meta, :param, :source, :track, :wbr]

  def self.array_to_html(data)
    return "" if data.empty?
    if data[1]? && data[1].is_a? NamedTuple
      self.tag_with_attrs(data)
    else
      self.tag_without_attrs(data)
    end
  end

  def self.named_tuple_to_html(data)
    # converts key value pairs to html attributes
    # e.g. {id: "main", class: "blue"} => "id=\"main\" class=\"blue\""
    String.build do |str|
      data.keys.each do |key|
        str << " " << key.to_s << "="
        str << "\"" << Crikey.to_attr(data[key]) << "\""
      end
    end
  end

  def self.to_attr(data)
    data.to_s
  end

  def self.to_html(data)
    case data
    when Array
      self.array_to_html(data)
    when String
      data
    when Symbol
      data.to_s
    when NamedTuple
      self.named_tuple_to_html(data)
    when Int
      data.to_s
    end
  end

  def self.tag_without_attrs(data)
    String.build do |str|
      case data.first
			when Symbol
				if Crikey::AUTO_CLOSING_TAGS.includes? data.first
					str << "<" << data.first.to_s << " />"
				else
					str << "<" << data.first.to_s << ">"
					data[1..-1].each {|t| str << Crikey.to_html(t) }
					str << "</" << data.first.to_s << ">"
				end
      when Array
				data.each {|t| str << Crikey.to_html(t) }
			when String
				str << data.first
      end
    end
  end

  def self.tag_with_attrs(data)
    String.build do |str|
      case data.first
			when Symbol
				if Crikey::AUTO_CLOSING_TAGS.includes? data.first
					str << "<" << data.first.to_s << Crikey.to_html(data[1]) << " />"
				else
					str << "<" << data.first.to_s << Crikey.to_html(data[1]) << ">"
					data[2..-1].each {|t| str << Crikey.to_html(t) }
					str << "</" << data.first.to_s << ">"
				end
      when Array
				data.each {|t| str << Crikey.to_html(t) }
			when String
				str << data.first
			end
    end
  end

  macro embed(filename, io_name)
    {{io_name.id}} << {{ run("./embed/embedder.cr", filename) }}
    {{io_name.id}}
  end
end
