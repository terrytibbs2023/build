import requests
import routing


class DI:
    session = requests.sessions.Session()
    plugin = routing.Plugin()

DI = DI()
