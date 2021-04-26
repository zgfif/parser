# frozen_string_literal: true

require_relative './lib/parser'

parser = Parser.new(ENV['GSM_EMAIL'], ENV['GSM_PASS'])
p parser.favorite_devices
