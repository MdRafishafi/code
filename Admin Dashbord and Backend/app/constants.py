from os import environ, path

SENDER_EMAIL = environ.get('SENDER_EMAIL') or 'bmtcmy@gmail.com'
SENDER_PASSWORD = environ.get('SENDER_PASSWORD') or 'shafi20015'
APP_ROOT = path.dirname(path.abspath(__file__))
SMS_API_KEY = environ.get('SMS_API_KEY')
SMS_URL = environ.get('SMS_URL')
SESSION_TIME = 10 * 24 * 60 * 60
LATITUDE = 0.00090053582
LONGITUDE = 0.00113804251
