# frozen_string_literal: true

require 'mechanize'

# this class designed to signin and retrieve favorite devices from account
class Parser
  # pass here registered email and password
  def initialize(email, pass)
    @email = email
    @pass = pass
    @agent = Mechanize.new { |a| a.follow_meta_refresh = true }
    @page = @agent.get('https://gsmarena.com/')
  end

  # performes authorization and returns reference to profile
  def signin
    pass_authorization
    @page.links.find { |l| l.text.match?(/pavlik5727/) }
  end

  # returns the xml node of required content
  def favorite_devices
    content = signin.click.search('div.makers ul li a strong')
    data_array(content)
  end

  private

  # fill in signin form and submit
  def pass_authorization
    form = @page.forms[1]
    form.sEmail = @email
    form.sPassword = @pass
    @page = @agent.submit(form)
  end

  # returns array of favorite phones
  def data_array(content)
    result = []

    content.each_with_index do |elem, i|
      inner = elem.children[0]
      item = { id: i, brand: brand(inner), model: model(inner) }

      result << item
    end

    # result looks like:
    # [{ id: 1, brand: IPhone, model: 6s }, ..., { id: 10, ... }]
    result
  end

  # extracts phone's brand
  def brand(item)
    item.children[0].text
  end

  # extracts phone's model
  def model(item)
    item.children[2].text
  end
end
