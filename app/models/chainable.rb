module Chainable
  def next_in_chain(link)
    @next = link
  end

  def method_missing(method, *args, &block)
    if @next.nil?
      raise "method '#{method}' has no next in chain"
    else
      @next.send(method, *args, &block)
    end
  end
end

class Checker
  include Chainable

  def initialize(link=nil)
    next_in_chain(link)
  end

  def verify_url(url)
    raise "bad words like '#{url}' are not allowed!" if !clean?(url)
    raise "url '#{url}' is badly formatted" if !valid?(url)

    short_url = randomize(url)
    #short_url = 
  end
end

class UrlChecker
  include Chainable

  def initialize(link=nil)
    next_in_chain(link)
  end
    
  def valid?(url)
    # todo: add real check for valid URI
    # for now just need at least one dot
    url.count('.') >= 1
  end
end

class UrlRandomizer
  include Chainable

  def initialize(link=nil)
    next_in_chain(link)
  end
    
  def randomize(url)
    rand(36**8).to_s(36)
  end
end

class BadWordFilter
  include Chainable

  def initialize(link=nil)
    next_in_chain(link)
  end
    
  def clean?(url)
    # todo: add real bad word filter
    !%w[foo bar baz].include?(url)
  end
end
