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
    begin
      clean?(url)
      valid?(url)
    rescue => exception
      raise exception
    end

    short_url = randomize
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
    # and not empty
    if url.empty? || url.count('.') < 1
      raise "url '#{url}' is badly formatted"
    end
  end
end

class UrlRandomizer
  include Chainable

  def initialize(link=nil)
    next_in_chain(link)
  end
    
  def randomize
    repeat_random
  end

  private

  def repeat_random
    text = ''
    begin
      text = random_string
    end while LongUrl.all.include?(text)

    text
  end

  def random_string
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
    if %w[foo bar baz].include?(url)
      raise "bad words like '#{url}' are not allowed!"
    end
  end
end
