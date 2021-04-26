require 'mechanize'

class Parser
  def initialize(email, pass) # pass here registered email and password
    @email = email
    @pass = pass
    @agent = Mechanize.new { |a| a.follow_meta_refresh = true }
    @page = @agent.get('https://gsmarena.com/')
  end

  def signin # performes authorization and returns reference to profile
    pass_authorization
    @page.links.find { |l| l.text.match?(/pavlik5727/)}
  end

  def get_favorite_devices # returns the xml node of required content
    content = signin.click.search('div.makers ul li a strong')
    data_array(content)
  end

  private

  def pass_authorization # fill in signin form and submit
    form = @page.forms[1]
    form.sEmail = @email
    form.sPassword = @pass
    @page = @agent.submit(form)
  end

  def data_array(content) # returns array of favorite phones
    result = []

    content.each_with_index do |elem, i|
      inner = elem.children[0]
      item = { id: i, brand: get_brand(inner), model: get_model(inner) }

      result << item
    end

    result # [{ id: 1, brand: IPhone, model: 6s }, ..., { id: 10, ... }]
  end

  def get_brand(item) # extracts phone's brand
    item.children[0].text
  end

  def get_model(item) # extracts phone's model
    item.children[2].text
  end
end
