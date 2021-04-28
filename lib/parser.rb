# frozen_string_literal: true

require_relative '../capybara_config'

# this class is used to signin and retrieve favorite phones from gsmarena.com
class Parser
  include Capybara::DSL

  def initialize(email, pass)
    @email = email
    @pass = pass
  end

  def signin
    visit('https://gsmarena.com')
    click_link('login-active')
    fill_in('sEmail', with: ENV['GSM_EMAIL'])
    fill_in('sPassword', with: ENV['GSM_PASS'])
    find_button('nick-submit').click
    sleep 5
    find('#login-active')
  end

  def favorite_devices
    signin unless authorized?

    click_link('login-active')

    content = all('div.makers ul li')

    process_content(content)
  end

  def authorized?
    on_site? && all('a')[7]['href'].match?(/account.php3/)
  end

  private

  def on_site?
    current_path.match?(%r{/})
  end

  def process_content(content)
    result = []

    content.each_with_index do |el, i|
      brand, model = el.find('span').text.split("\n")

      result << { id: i, brand: brand, model: model }
    end

    result
  end
end
