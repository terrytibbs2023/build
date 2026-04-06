import requests, time, xbmc, re
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs
from threading import Thread
import binascii

base_url = ""
domain = ""
x = 0
# xbmc.log = print

# Advanced caching for .ts and .mp4
IP_CACHE_TS = {}
IP_CACHE_MP4 = {}

def get_cache_key(url):
    return url


class MyServer(BaseHTTPRequestHandler):
    def m3u8(self, req_type: str):
        global domain
        global base_url
        global x

        parse = urlparse(self.path)
        query = parse_qs(parse.query)
        if "url" not in query:
            self.send_response(400)
            self.end_headers()
            return
        url = query["url"][0]
        domain = urlparse(url).netloc
        headers = dict(self.headers)
        del headers["Host"]
        # Force User-Agent, Accept, and blank Referer for all requests
        headers["User-Agent"] = (
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) "
            "Gecko/20100101 Firefox/117.0"
        )
        headers["Accept"] = "*/*"
        headers["Referer"] = ""
        # Debug log all request headers
        xbmc.log(f"JetProxy: Request headers: {headers}", xbmc.LOGINFO)

        # DNS override stub (implement as needed)
        # def dns_override(): pass

        r = requests.get(url, headers=headers, stream=True) if req_type == "GET" else requests.head(url, headers=headers)
        # Debug log all response headers
        xbmc.log(f"JetProxy: Response headers: {dict(r.headers)}", xbmc.LOGINFO)
        if r.status_code in [403, 404]:
            xbmc.log(f"JetProxy: got status code {r.status_code}; start retrying (x = {x})", xbmc.LOGINFO)
            for i in range(20):
                headers["User-Agent"] = headers["User-Agent"] + str(x)
                x += 1
                r = requests.get(url, headers=headers) if req_type == "GET" else requests.head(url, headers=headers)
                if r.status_code == 200:
                    break
                xbmc.log(f"JetProxy: got status code {r.status_code}; retrying ({i + 1} / 20)", xbmc.LOGINFO)
                time.sleep(3)
        r_parse = urlparse(r.url)
        base_url = "http://" + r_parse.netloc
        self.send_response(r.status_code)
        for key, value in r.headers.items():
            if key in ["Server", "Date", "Connection", "Content-Length"]:
                continue
            self.send_header(key, value)
        self.end_headers()
        if req_type == "GET":
            if "mp2t" in r.headers["Content-Type"]:
                cache_key = get_cache_key(url)
                if cache_key not in IP_CACHE_TS:
                    IP_CACHE_TS[cache_key] = []
                e = False
                while not e:
                    for chunk in r.iter_content(chunk_size=16384):
                        try:
                            self.wfile.write(chunk)
                            # Cache last 20 chunks
                            IP_CACHE_TS[cache_key].append(chunk)
                            if len(IP_CACHE_TS[cache_key]) > 20:
                                IP_CACHE_TS[cache_key].pop(0)
                        except Exception as ex:
                            xbmc.log(f"JetProxy: chunk streaming error: {ex}", xbmc.LOGERROR)
                            e = True
                            break
                    if not e:
                        xbmc.log(f"JetProxy: got EOF; retrying", xbmc.LOGINFO)
                        r = requests.get(url, headers=headers, stream=True)
                # On error, replay last 5 cached chunks
                for chunk in IP_CACHE_TS[cache_key][-5:]:
                    self.wfile.write(chunk)
            else:
                text = []
                for line in r.iter_lines():
                    text.append(line.decode("utf-8"))
                text = "\n".join(text)
                # Only rewrite lines that are actual URLs, not metadata or color tags
                lines = text.splitlines()
                new_lines = []
                for line in lines:
                    if line.startswith("http://"):
                        line = f"http://127.0.0.1:49777/?url={line}"
                    new_lines.append(line)
                text = "\n".join(new_lines)
                self.wfile.write(text.encode("utf-8"))
                
                 
            # else:
            #     while True:
            #         r = requests.get(url, stream=True)
            #         self.send_response(r.status_code)
            #         for key, value in r.headers.items():
            #             if key in ["Server", "Date", "Connection"]:
            #                 continue
            #             self.send_header(key, value)
            #         self.end_headers()
            #         for chunk in r.iter_content(chunk_size=16384):
            #             self.wfile.write(chunk)
           
    
    def ts(self, req_type: str):
        global domain
        global base_url

        parse = urlparse(self.path)
        query = parse_qs(parse.query)
        if "url" not in query:
            url = base_url + self.path
        else:
            url = query["url"][0]
            domain = parse.netloc
        headers = dict(self.headers)
        del headers["Host"]
        # Force User-Agent, Accept, and blank Referer for all requests
        headers["User-Agent"] = (
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) "
            "Gecko/20100101 Firefox/117.0"
        )
        headers["Accept"] = "*/*"
        headers["Referer"] = ""
        # Debug log all request headers
        xbmc.log(f"JetProxy: Request headers: {headers}", xbmc.LOGINFO)
        r = requests.get(url, headers=headers) if req_type == "GET" else requests.head(url, headers=headers)
        # Debug log all response headers
        xbmc.log(f"JetProxy: Response headers: {dict(r.headers)}", xbmc.LOGINFO)
        self.send_response(r.status_code)
        for key, value in r.headers.items():
            if key in ["Server", "Date", "Connection"]:
                continue
            self.send_header(key, value)
        self.end_headers()
        if req_type == "GET":
            cache_key = get_cache_key(url)
            if cache_key not in IP_CACHE_TS:
                IP_CACHE_TS[cache_key] = []
            try:
                for chunk in r.iter_content(chunk_size=16384):
                    self.wfile.write(chunk)
                    IP_CACHE_TS[cache_key].append(chunk)
                    if len(IP_CACHE_TS[cache_key]) > 20:
                        IP_CACHE_TS[cache_key].pop(0)
            except Exception as ex:
                xbmc.log(f"JetProxy: ts chunk streaming error: {ex}", xbmc.LOGERROR)
                # On error, replay last 5 cached chunks
                for chunk in IP_CACHE_TS[cache_key][-5:]:
                    self.wfile.write(chunk)

    def do_HEAD(self):
        if "index.bdm" in self.path.lower() or "video_ts.ifo" in self.path.lower():
            self.send_response(404)
            self.end_headers()
            return
        if self.path.endswith(".m3u8"):
            self.m3u8("HEAD")
        elif self.path.endswith(".ts"):
            self.ts("HEAD")

    def do_GET(self):
        if "index.bdm" in self.path.lower() or "video_ts.ifo" in self.path.lower():
            self.send_response(404)
            self.end_headers()
            return
        if self.path == "/stop":
            self.send_response(200)
            self.end_headers()

            def shutdown(server):
                server.shutdown()
            thread = Thread(target=shutdown, args=(self.server,))
            thread.setDaemon(True)
            thread.start()
        elif self.path.endswith(".ts") or (self.path.startswith("/hls/") and not self.path.endswith(".ts") and not self.path.endswith(".m3u8")):
            self.ts("GET")
        else:
            self.m3u8("GET")

if __name__ == "__main__":
    webServer = HTTPServer(("127.0.0.1", 49777), MyServer)
    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        webServer.server_close()