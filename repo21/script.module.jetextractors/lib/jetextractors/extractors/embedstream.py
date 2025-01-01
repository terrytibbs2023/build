import requests, re, xbmc
from ..models import JetExtractor, JetLink
from .plytv import PlyTv

class Embedstream(JetExtractor):
    def __init__(self) -> None:
        self.domains = ["embedstream.me"]
        self.name = "Embedstream"
        self.resolve_only = True

    def _log(self, msg, level=xbmc.LOGINFO):
        xbmc.log(f"[Embedstream] {msg}", level)

    def _parse_m3u8_url(self, url):
        try:
            if not url:
                return None, {}
                
            # Split URL and parameters
            parts = url.split("|", 1)
            stream_url = parts[0].strip()
            
            # Parse headers
            headers = {
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
            }
            
            if len(parts) > 1:
                params = parts[1].split("&")
                for param in params:
                    if "=" in param:
                        key, value = param.split("=", 1)
                        headers[key.strip()] = value.strip()
            
            return stream_url, headers
        except Exception as e:
            self._log(f"Error parsing m3u8 URL: {str(e)}", xbmc.LOGERROR)
            return None, {}

    def embedstream(self, id: str):
        try:
            if not id:
                self._log("No ID provided")
                return None
                
            # If it's a direct m3u8 URL, handle it
            if ".m3u8" in id:
                self._log(f"Direct m3u8 URL found")
                stream_url, headers = self._parse_m3u8_url(id)
                if stream_url:
                    self._log(f"Returning direct m3u8 stream")
                    return JetLink(stream_url, headers=headers)
                return None
                
            # Clean up the ID - remove any full URLs and whitespace
            id = id.replace("https://embedstream.me/", "").replace("https://embedsports.me/", "").strip()
            if not id:
                self._log("Empty ID after cleanup")
                return None
                
            # If it's an embedsports stream, handle it directly
            if "stream" in id and any(sport in id for sport in ["nba", "nfl", "nhl", "mlb"]):
                self._log(f"Processing embedsports stream")
                r = requests.get(f"https://embedsports.me/{id}", headers={
                    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
                    "Referer": "https://embedstream.me/"
                }).text
                
                # Try to find direct stream URL
                m3u8_url = re.findall(r'source:\s*["\'](.+?\.m3u8.*?)["\']', r)
                if m3u8_url and m3u8_url[0]:
                    stream_url = m3u8_url[0]
                    if not stream_url.startswith('http'):
                        stream_url = 'https:' + stream_url if stream_url.startswith('//') else 'https://embedsports.me' + stream_url
                    self._log(f"Found direct m3u8 stream")
                    return JetLink(stream_url, headers={
                        "Referer": f"https://embedsports.me/{id}",
                        "Origin": "https://embedsports.me",
                        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
                    })
                
                # Try to find iframe with stream
                iframe = re.findall(r'iframe.+?src="(.+?)"', r)
                if iframe and iframe[0]:
                    iframe_url = iframe[0]
                    if not iframe_url.startswith('http'):
                        iframe_url = 'https:' + iframe_url if iframe_url.startswith('//') else 'https://embedsports.me' + iframe_url
                    
                    self._log(f"Found iframe, checking for stream")
                    r_iframe = requests.get(iframe_url, headers={
                        "Referer": f"https://embedsports.me/{id}",
                        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
                    }).text
                    
                    m3u8_url = re.findall(r'source:\s*["\'](.+?\.m3u8.*?)["\']', r_iframe)
                    if m3u8_url and m3u8_url[0]:
                        stream_url = m3u8_url[0]
                        if not stream_url.startswith('http'):
                            stream_url = 'https:' + stream_url if stream_url.startswith('//') else 'https://embedsports.me' + stream_url
                        self._log(f"Found iframe m3u8 stream")
                        return JetLink(stream_url, headers={
                            "Referer": iframe_url,
                            "Origin": "https://embedsports.me",
                            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
                        })
            
            # If not embedsports or no stream found, try embedstream
            self._log(f"Trying embedstream")
            r_embedstream = requests.get("https://embedstream.me/" + id, headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
            }).text
            
            # Try to find direct m3u8 stream first
            m3u8_url = re.findall(r'source:\s*["\'](.+?\.m3u8.*?)["\']', r_embedstream)
            if m3u8_url and m3u8_url[0]:
                stream_url = m3u8_url[0]
                if not stream_url.startswith('http'):
                    stream_url = 'https:' + stream_url if stream_url.startswith('//') else 'https://embedstream.me' + stream_url
                self._log(f"Found embedstream m3u8")
                return JetLink(stream_url, headers={
                    "Referer": "https://embedstream.me/",
                    "Origin": "https://embedstream.me",
                    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
                })
            
            # Try the old PlyTv method as last resort
            self._log("Trying PlyTv method")
            zmid = re.compile(r'zmid = "(.+?)"').findall(r_embedstream)
            if zmid and zmid[0]:
                try:
                    game_cat_match = re.findall(r'gameCat="(.+?)"', r_embedstream)
                    if not game_cat_match:
                        self._log("No gameCat found")
                        return None
                        
                    game_cat = game_cat_match[0]
                    self._log(f"Found PlyTv stream")
                    plytv_link = PlyTv().plytv_sdembed(game_cat, zmid[0], "https://embedstream.me/")
                    if plytv_link and hasattr(plytv_link, 'address') and plytv_link.address:
                        self._log(f"Got PlyTv stream")
                        return plytv_link
                    else:
                        self._log("PlyTv link invalid")
                except Exception as e:
                    self._log(f"PlyTv error: {str(e)}", xbmc.LOGERROR)
                
        except Exception as e:
            self._log(f"Embedstream error: {str(e)}", xbmc.LOGERROR)
        
        self._log("No valid stream found")
        return None

    def get_link(self, url: JetLink) -> JetLink:
        try:
            if not url:
                self._log("No URL provided")
                return None
                
            if not hasattr(url, 'address') or not url.address:
                self._log("URL has no address")
                return None
            
            # Clean up the URL before processing
            address = url.address.strip()
            if not address:
                self._log("Empty address after cleanup")
                return None
                
            # Handle direct m3u8 URLs
            if ".m3u8" in address:
                self._log("Processing direct m3u8 URL")
                stream_url, headers = self._parse_m3u8_url(address)
                if stream_url:
                    return JetLink(stream_url, headers=headers)
                return None
                
            # Handle embedsports URLs
            if "embedsports.me" in address:
                self._log("Processing embedsports URL")
                path = address.split("embedsports.me/")[-1].split("|")[0]
                return self.embedstream(path)
            
            # Handle embedstream URLs
            if "embedstream.me" in address:
                self._log("Processing embedstream URL")
                path = address.split("embedstream.me/")[-1].split("|")[0]
                return self.embedstream(path)
            
            # Handle direct paths
            self._log("Processing direct path")
            return self.embedstream(address)
            
        except Exception as e:
            self._log(f"get_link error: {str(e)}", xbmc.LOGERROR)
            return None