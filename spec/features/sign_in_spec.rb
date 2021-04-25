Capybara.default_driver = :selenium_chrome
Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)

describe 'the signin process', type: :feature do
  before(:each) do
    visit('https://gsmarena.com')
  end

  it 'should not be sign in' do
    expect(find('.signup-icon')).to have_selector('.icon-user-plus')
  end

  context 'after sign in' do
    before(:each) do
      click_link('login-active')
      fill_in('sEmail', with: ENV['GSM_EMAIL'])
      fill_in('sPassword', with: ENV['GSM_PASS'])
      find('#nick-submit').click
      sleep 5
    end

    it 'should sign in' do
      expect(find('.signup-icon')).to have_selector('.icon-signout')
    end

    it 'should retrieve favorite devices' do
      click_link('login-active')
      devices = all('.makers ul li')
      expect(devices[0]).to have_content("Realme\nGT Neo")
      expect(devices[4]).to have_content("Samsung\nGalaxy A52")
    end
  end
end
