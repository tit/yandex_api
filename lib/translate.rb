#encoding utf-8

require "rubygems"
require "open-uri"
require "json"

class Translate
  # api_interface can be :json, :jsonp or :xml
  # JSONP temporarily unavailable by Yandex
  # XML temporarily unavailable by TIT
  def initialize api_interface = :json#, callback = :callback
    # @api_interface = api_interface
    case api_interface
    when :json
      @api_uri = "http://translate.yandex.net/api/v1/tr.json"
    when :jsonp
      #@api_uri = "http://translate.yandex.net/api/v1/tr.json/callback=#{callback}"
    when :xml
      #@api_uri = "http://translate.yandex.net/api/v1/tr/"
    else
      raise ArgumentError, "You try use unavailable interface."
    end  
  end

  def getLangs
    request = URI.encode "#{@api_uri}/getLangs"
    response = open request
    json_hash = JSON.parse response.read
    dirs = json_hash["dirs"]
    return dirs
  end

  # format can be :plain or :html
  def detect text, format = :plain
    request = URI.encode "#{@api_uri}/detect?text=#{text}&format=#{format}"
    response = open request
    json_hash = JSON.parse response.read
    code = json_hash["code"].to_i
    lang = json_hash["lang"]
    result = Hash.new
    result = {"code" => code, "lang" => lang}
    return result
  end

  def translate lang, text, format = :plain
    request = URI.encode "#{@api_uri}/translate?lang=#{lang}&text=#{text}&format=#{format}"
    response = open request
    json_hash = JSON.parse response.read    
    code = json_hash["code"].to_i
    lang = json_hash["lang"]
    text = json_hash["text"]
    result = Hash.new
    result = {"code" => code, "lang" => lang, "text" => text}
    return result
  end
end