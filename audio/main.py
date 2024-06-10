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