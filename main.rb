require_relative './lib/parser'
parser = Parser.new(ENV['GSM_EMAIL'], ENV['GSM_PASS'])
p parser.get_favorite_devices
