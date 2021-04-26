require 'mechanize'

class Parser
  def initialize(email, pass)
    @email = email
    @pass = pass
    @agent = Mechanize.new { |a| a.follow_meta_refresh = true }
    @page = @agent.get('https://gsmarena.com/')
  end

  def signin
    pass_authorization
    @page.links.find { |l| l.text.match?(/pavlik5727/)}
  end

  def get_favorite_devices
    result = []
    @page = signin.click
    content = @page.search('div.makers ul li a strong')

    content.each_with_index do |elem, index|
      inner_content = elem.children[0]
      item = {id: index}
      item[:brand] = inner_content.children[0].text
      item[:model] = inner_content.children[2].text
      result << item
    end

    result
  end

  private

  def pass_authorization
    form = @page.forms[1]
    form.sEmail = @email
    form.sPassword = @pass
    @page = @agent.submit(form)
  end
end
