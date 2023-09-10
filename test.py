from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time

print("Start")
# create chrome instance
opt = Options()
#opt.add_argument("--headless=new")
opt.add_argument('--disable-blink-features=AutomationControlled')
opt.add_argument("--enable-features=AudioServiceOutOfProcess")
#opt.add_argument('--start-maximized')
opt.add_experimental_option("prefs", {
    "profile.default_content_setting_values.media_stream_mic": 1,
    "profile.default_content_setting_values.media_stream_camera": 1,
    "profile.default_content_setting_values.geolocation": 0,
    "profile.default_content_setting_values.notifications": 1
})

print("Create Driver....", end="")
driver = webdriver.Chrome(options=opt)
print("OK")
 
print("Go to page....", end="")
# go to google meet
driver.get('https://www.youtube.com/watch?v=7WWlDgNpTvM')
print("OK")
time.sleep(30)
print("End")