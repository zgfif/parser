require 'mechanize'

class Parser
  def initialize; end

  def log_in
    agent = Mechanize.new
    agent.follow_meta_refresh = true
    page = agent.get('https://gsmarena.com/')

    page.links.find{ |l| l.text.match?(/Log in/) }.click
    f = page.forms[1]
    f.sEmail = ENV['GSM_EMAIL']
    f.sPassword = ENV['GSM_PASS']
    page = agent.submit(f, f.buttons[0])

    'some text'
  end

  def retrieve_data
    'data'
  end
end
