# encoding utf-8

require "translate"

translate = Translate.new :json

puts translate.getLangs
puts translate.detect("привет", :plain)["lang"]
puts translate.translate("en-ru", "hi", :plain)["text"].to_s