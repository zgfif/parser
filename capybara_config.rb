# frozen_string_literal: true

require 'capybara/dsl'
Capybara.default_driver = :selenium_chrome
Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)
