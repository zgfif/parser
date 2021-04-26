This project is created to parse favorite devices from user's account on https://gsmarena.com.

# Installation:  
*1 Step:* in your terminal run `bundle install`  
*2 Step:* create an account on gsmarena.com  
*3 Step:* create environment variables: `GSM_EMAIL` and `GSM_PASS` with corresponding  
        registered email and password.  
*4 Step:* to retrieve scraped data run in terminal `ruby main.rb`.  

# Tests  
Use  command `rspec` to run all spec tests.  
### **Note:** to run rspec/capybara tests install selenium_chrome.  
###For Linux you can use:  
`sudo apt-get install chromium-driver`  
Read more https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver
