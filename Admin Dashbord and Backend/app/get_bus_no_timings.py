import time
from os import path
from app import app, constants as c
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.chrome.options import Options

user_need_details = {}


def get_url_setting_to_loc(from_loc_lat, from_loc_long, to_loc_lat, to_loc_long):
    chrome_options = Options()
    chrome_options.add_argument("--disable-extensions")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--headless")
    driver = webdriver.Chrome(path.join(c.APP_ROOT, "chromedriver.exe"), chrome_options=chrome_options)
    driver.get(
        f"https://www.google.com/maps/dir/'{from_loc_lat},{from_loc_long}'/'{to_loc_lat},{to_loc_long}'/@13.1604339,77.6366039,15z/am=t/data=!4m10!4m9!1m3!2m2!1d77.6366039!2d13.1604339!1m3!2m2!1d{to_loc_long}!2d{to_loc_lat}!3e3")
    get_user_details_from_website(driver)


def get_user_details_from_website(driver):
    time.sleep(2)
    temp = []

    def add_all(data, d):
        c = 0
        for i in range(len(data)):
            if data[i].text:
                temp[c][d] = data[i].text
                c += 1

    try:
        user_need_details["toatal_time"] = str(
            driver.find_element_by_css_selector(".section-trip-summary-header h1").text)
        user_need_details["cost"] = str(
            driver.find_elements_by_css_selector(".section-directions-trip-secondary-text")[1].text)[1:]
        details = driver.find_element_by_css_selector(".ykrkG-trip-MZArnb")
        bus_start_timings = details.find_elements_by_css_selector(".transit-stop .directions-mode-group-departure-time")
        locations = details.find_elements_by_css_selector(".transit-stop-details h2")
        timings_no_of_stop = details.find_elements_by_css_selector(".transit-step-details")
        bus_no = details.find_elements_by_css_selector(".renderable-component-text-box-content")

        for i in range(len(bus_start_timings)):
            if bus_start_timings[i].text:
                temp.append({"starting_bus_timing": bus_start_timings[i].text})
        test = []
        for i in range(len(timings_no_of_stop)):
            if timings_no_of_stop[i].text:
                test.append(timings_no_of_stop[i].text)
        if str(test[0]).startswith("About"):
            test.pop(0)
        if str(test[-1]).startswith("About"):
            test.pop(-1)
        c = 0
        i = 0
        for t in test:
            if str(t).startswith("About"):
                c += 1
            else:
                temp[i]["starting_bus_stop"] = locations[c].text
                temp[i]["end_bus_stop"] = locations[c + 1].text
                temp[i]["timings_and_no_of_stop"] = t
                c += 1
                i += 1
        add_all(bus_no, "bus_no")
        user_need_details["bus_details"] = temp
        getting_iframe(driver)
    except NoSuchElementException:
        get_user_details_from_website(driver)


def getting_iframe(driver):
    def getting_iframe1():
        try:
            driver.find_elements_by_css_selector(
                ".Tzqkt-T3iPGc-MZArnb-JIbuQc button")[1].click()
        except:
            getting_iframe1()

    def getting_iframe2():
        try:
            driver.find_elements_by_css_selector(".s4ghve-AznF2e-ZMv3u button")[1].click()
            user_need_details["iframe"] = str(driver.find_element_by_css_selector("input").get_attribute("value")).replace("\"","'")
            return user_need_details
        except:
            getting_iframe2()

    time.sleep(2)
    getting_iframe1()
    getting_iframe2()
    driver.close()


@app.route('/get-bus-no-from-to/<from_loc_lat>/<from_loc_long>/<to_loc_lat>/<to_loc_long>', methods=["GET"])
def get_bus_no_timings(from_loc_lat, from_loc_long, to_loc_lat, to_loc_long):
    try:
        get_url_setting_to_loc(from_loc_lat=from_loc_lat,
                               from_loc_long=from_loc_long,
                               to_loc_lat=to_loc_lat,
                               to_loc_long=to_loc_long
                               )
    except:
        return {
            "message": "Something went wrong"
        }, 300
    while "iframe" not in user_need_details.keys():
        pass
    return user_need_details
