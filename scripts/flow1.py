import os
import base64

from selenium import webdriver
from selenium.webdriver.chrome.options import Options


def chrome_driver_work():
    options = Options()
    options.binary_location = '/usr/bin/chromium'
    options.add_argument('--headless=new')  # '--headless'
    driver = webdriver.Chrome(options=options)  # executable_path='/path/to/chromedriver

    # base64.b64encode('<url>'.encode('utf-8')).decode()
    wd_download(driver, decode64('aHR0cHM6Ly93d3cubWFya2V0d2F0Y2guY29tL2ludmVzdGluZy9pbmRleC9kamlh'), 'mw_djia')

    driver.quit()


def decode64(s):
    return base64.b64decode(s).decode('utf-8')


def wd_download(driver, url, output_file, remove_script=True):
    driver.get(url)
    
    if remove_script:
        remove_element(driver, ['script', 'link', 'meta', 'style'])
        
    with open(output_file, 'w', encoding='utf-8') as f:
        ## print(driver.page_source[:10240])
        # f.write(driver.page_source)
        print(get_element_html('table'))

        
def remove_element(driver, selectors):
    #element = driver.execute_script("return document.querySelector('h1')")
    #driver.execute_script("arguments[0].setAttribute('style', 'color: red')", element)
    for selector in selectors:
        script = """
            var elements = document.querySelectorAll("%s");
            for (var i = 0; i < elements.length; i++) {
                elements[i].remove();
            }
            """ % selector
        driver.execute_script(script)

        
def get_element_html(driver, selector):
    script = """
        var html = ""
        var elements = document.querySelectorAll("%s");
        for (var i = 0; i < elements.length; i++) {
            html += elements[i].outerHTML;
        }
        return html;
    """    
    return driver.execute_script(script)



        

        
if __name__ == '__main__':
    chrome_driver_work()
