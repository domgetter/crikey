require "./crikey/*"

class Array
  def tag_without_attrs
    String.build do |str|
      case self.first
      when Symbol
        str << "<" << self.first.to_s << ">"
        self[1..-1].each {|t| str << t.to_html }
        str << "</" << self.first.to_s << ">"
      when Array
        self.each {|t| str << t.to_html }
      end
    end
  end

  def tag_with_attrs
    String.build do |str|
      case self.first
      when Symbol
        str << "<" << self.first.to_s << self[1].to_html << ">"
        self[2..-1].each {|t| str << t.to_html }
        str << "</" << self.first.to_s << ">"
      when Array
        self.each {|t| str << t.to_html }
      end
    end
  end

  def to_html
    return "" if self.empty?
    if self[1].is_a? NamedTuple
      self.tag_with_attrs
    else
      self.tag_without_attrs
    end
  end
end

class String
  def to_html
    self
  end
end

struct Symbol
  def to_html
    self.to_s
  end
end

struct NamedTuple
  def to_html
    # converts key value pairs to html attributes
    # e.g. {id: "main", class: "blue"} => "id=\"main\" class=\"blue\""
    String.build do |str|
      self.keys.each do |key|
        str << " " << key.to_s << "="
        str << "\"" << self[key].to_html << "\""
      end
    end
  end
end

struct Int
  def to_html
    self.to_s
  end
end

module Crikey
  # TODO Put your code here

  # puts [:div, "hello"].to_html
  # puts [:ul, [:li, 1], [:li, 2]].to_html
  # puts [:div, {id: "main"}, "main div"].to_html
  # puts [:div, {id: "main", class: "blue"}, [:div, "some content"], [:div, "footer"]].to_html
  # puts [:div, ["hi", "you"]]
  # tweets = [{username: "PDawg19", content: "awesome. \#lazysunday"}, {username: "SaraJane", content: "That was awful"}]
  # tweet_div = -> (tweet : NamedTuple(username: String, content: String)) {
  #   [:div, {class: "tweet"},
  #    [:h1, tweet[:username]],
  #    [:span, tweet[:content]]]
  # }
  # puts [:div, tweets.map(&tweet_div)]
  # puts [:div, tweets.map(&tweet_div)].to_html
  # puts ([:div] + tweets.map(&tweet_div)).to_html
end
