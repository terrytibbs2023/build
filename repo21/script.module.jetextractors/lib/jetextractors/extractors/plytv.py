import requests, re, base64, xbmc
from bs4 import BeautifulSoup
from pyjsparser import parse
from ..models import *
from ..util.hunter import hunter

class PlyTv(JetExtractor):
    def __init__(self) -> None:
        self.domains = ["reliabletv.me", "plytv.me", "kenitv.me"]
        self.name = "PlyTv"
        self.resolve_only = True
        self.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

    def _log(self, msg: str, level: int = xbmc.LOGINFO) -> None:
        xbmc.log(f"[PlyTv] {msg}", level)

    def get_link(self, url: JetLink) -> Optional[JetLink]:
        try:
            if not isinstance(url, JetLink):
                self._log("Input is not a JetLink object", xbmc.LOGWARNING)
                if isinstance(url, str):
                    url = JetLink(address=url)
                else:
                    return None

            if not url or not url.address:
                self._log("Invalid URL or empty address", xbmc.LOGWARNING)
                return None

            self._log(f"Processing URL: {url.address}")

            # Try to get the page content
            try:
                headers = {
                    "User-Agent": self.user_agent,
                    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
                    "Accept-Language": "en-US,en;q=0.5",
                    "Connection": "keep-alive",
                    "Upgrade-Insecure-Requests": "1",
                    "Sec-Fetch-Dest": "iframe",
                    "Sec-Fetch-Mode": "navigate",
                    "Sec-Fetch-Site": "cross-site"
                }
                if url.headers:
                    headers.update(url.headers)

                r = requests.get(url.address, headers=headers, timeout=10)
                r.raise_for_status()
                content = r.text
                
                self._log("Successfully fetched page content")

                # Look for the encoded video URL
                video_patterns = [
                    r'const\s+videoUrl\s*=\s*["\']([^"\']+)["\']',
                    r'var\s+videoUrl\s*=\s*["\']([^"\']+)["\']',
                    r'videoUrl\s*=\s*["\']([^"\']+)["\']',
                    r'source:\s*["\']([^"\']+)["\']',
                    r'file:\s*["\']([^"\']+)["\']',
                    r'src:\s*["\']([^"\']+)["\']'
                ]
                
                for pattern in video_patterns:
                    video_url_match = re.search(pattern, content, re.IGNORECASE)
                    if video_url_match:
                        video_url = video_url_match.group(1)
                        self._log(f"Found encoded video URL: {video_url}")
                        
                        try:
                            # Try double base64 decode first
                            try:
                                decoded_url = base64.b64decode(base64.b64decode(video_url)).decode('utf-8')
                            except:
                                # If double decode fails, try single decode
                                try:
                                    decoded_url = base64.b64decode(video_url).decode('utf-8')
                                except:
                                    # If base64 decode fails, try direct URL
                                    decoded_url = video_url
                            
                            self._log(f"Decoded stream URL: {decoded_url}")
                            
                            if decoded_url:
                                if decoded_url.startswith('//'):
                                    decoded_url = 'https:' + decoded_url
                                elif not decoded_url.startswith('http'):
                                    decoded_url = 'https://' + decoded_url

                                return JetLink(
                                    address=decoded_url,
                                    headers={
                                        "Referer": url.address,
                                        "User-Agent": self.user_agent,
                                        "Origin": f"https://{self.domains[0]}",
                                        "Connection": "keep-alive",
                                        "Accept": "*/*",
                                        "Accept-Language": "en-US,en;q=0.5",
                                        "Sec-Fetch-Dest": "empty",
                                        "Sec-Fetch-Mode": "cors",
                                        "Sec-Fetch-Site": "cross-site"
                                    },
                                    inputstream=JetInputstreamAdaptive(
                                        manifest_type="hls",
                                        stream_headers={
                                            "Referer": url.address,
                                            "User-Agent": self.user_agent,
                                            "Origin": f"https://{self.domains[0]}"
                                        }
                                    ) if decoded_url.endswith('.m3u8') else None
                                )
                        except Exception as e:
                            self._log(f"Error decoding stream URL: {str(e)}", xbmc.LOGWARNING)
                            continue

                # If no direct stream found, look for additional iframes
                soup = BeautifulSoup(content, 'html.parser')
                for iframe in soup.find_all('iframe'):
                    if not iframe.get('src'):
                        continue
                        
                    iframe_url = iframe['src']
                    if iframe_url.startswith('//'):
                        iframe_url = 'https:' + iframe_url
                    elif not iframe_url.startswith('http'):
                        iframe_url = 'https://' + iframe_url

                    self._log(f"Found nested iframe: {iframe_url}")
                    
                    # Avoid infinite recursion
                    if iframe_url != url.address:
                        result = self.get_link(JetLink(
                            address=iframe_url,
                            headers={
                                "Referer": url.address,
                                "User-Agent": self.user_agent,
                                "Origin": f"https://{self.domains[0]}"
                            }
                        ))
                        if result and result.address:
                            return result

                self._log("No stream URL found", xbmc.LOGWARNING)
                return None

            except Exception as e:
                self._log(f"Failed to get page content: {str(e)}", xbmc.LOGERROR)
                return None

        except Exception as e:
            self._log(f"Error in get_link: {str(e)}", xbmc.LOGERROR)
            return None

    def plytv_sdembed(self, endpoint: str, vid: str, origin: str) -> Optional[JetLink]:
        try:
            if not endpoint or not vid:
                self._log("Missing endpoint or vid parameter", xbmc.LOGWARNING)
                return None

            # Normalize endpoint
            endpoint = endpoint.lower()
            if endpoint == "nba":
                endpoint = "basketball"

            # Try both URL formats
            urls = [
                f"https://reliabletv.me/sd0embed/{endpoint}/{vid}",
                f"https://reliabletv.me/sd0embed?v={vid}&sport={endpoint}"
            ]

            for url in urls:
                self._log(f"Trying plytv_sdembed with URL: {url}")
                headers = {
                    "User-Agent": self.user_agent,
                    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                    "Accept-Language": "en-US,en;q=0.5",
                    "Origin": origin,
                    "Referer": origin
                }

                result = self.get_link(JetLink(
                    address=url,
                    headers=headers
                ))
                if result and result.address:
                    return result

            self._log("No working URL found in plytv_sdembed", xbmc.LOGWARNING)
            return None
            
        except Exception as e:
            self._log(f"Error in plytv_sdembed: {str(e)}", xbmc.LOGERROR)
            return None
