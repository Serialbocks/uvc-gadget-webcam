import sys, os, time

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By

def main():
    
    driver = webdriver.Chrome()
    driver.get("http://192.168.0.180:8889/webcam")
    driver.maximize_window()
    body = driver.find_element(By.CSS_SELECTOR, "body")

    body.send_keys(Keys.CONTROL + Keys.HOME)
    time.sleep(10)

    video = driver.find_element(By.CSS_SELECTOR, "#video")
    location = video.location
    size = video.size
    w, h = size['width'], size['height']
    print(location)
    print(size)
    print(w, h)

    xoffset = (w / 2) - 120
    yoffset = (h / 2) - 23
    print(xoffset, yoffset)
    action = webdriver.common.action_chains.ActionChains(driver)
    action.move_to_element_with_offset(video, xoffset, yoffset)
    action.click()
    action.perform()

    while True:
        time.sleep(30)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(130)
        except SystemExit:
            os._exit(130)