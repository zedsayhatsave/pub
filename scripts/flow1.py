import os
import base64

from selenium import webdriver

def chrome_driver_work():
    driver = webdriver.Chrome()

    # base64.b64encode('<url>'.encode('utf-8')).decode()
    wd_download(driver, decode64('aHR0cHM6Ly93d3cubWFya2V0d2F0Y2guY29tL2ludmVzdGluZy9pbmRleC9kamlh'), 'mw_djia')

    driver.quit()


def decode64(s):
    return base64.b64decode(s).decode('utf-8')


def wd_download(driver, url, output_file, remove_script=True):
    driver.get("url")
    
    if remove_script:
        #element = driver.execute_script("return document.querySelector('h1')")
        #driver.execute_script("arguments[0].setAttribute('style', 'color: red')", element)
        driver.execute_script("""
            var elements = document.querySelectorAll("script");
            for (var i = 0; i < elements.length; i++) {
                 elements[i].remove();
            }
            """)
        
    with open("page_source.html", "w", encoding="utf-8") as f:
        f.write(driver.page_source)


if __name__ == '__main__':
    chrome_driver_work()
