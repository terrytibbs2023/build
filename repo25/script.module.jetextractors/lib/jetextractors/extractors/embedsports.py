from ..models import *
import requests
import base64
try:
    from Cryptodome.Cipher import AES
    from Cryptodome.Util import Counter
except Exception as _:
    try:
        from Crypto.Cipher import AES
        from Crypto.Util import Counter
    except Exception as _:
        pass

class Embedsports(JetExtractor):
    def __init__(self) -> None:
        self.domains = ["embedsports.top"]
        self.name = "Embedsports"
        self.resolve_only = True

    def get_link(self, url: JetLink) -> JetLink:
        split = url.address.split("/")
        stream_sc = split[-3]
        stream_id = split[-2]
        stream_no = split[-1]
        payload = bytes([
            0x0A, len(stream_sc), *stream_sc.encode("utf-8"),
            0x12, len(stream_id), *stream_id.encode("utf-8"),
            0x1A, len(stream_no), *stream_no.encode("utf-8")
        ])

        # Response payload: [0xA, len(enc), [pad], *enc]
        fetch = requests.post("https://embedsports.top/fetch", data=payload, headers={"Content-Type": "application/octet-stream"})
        b64_cipher_length = fetch.content[1]
        b64_cipher = fetch.content[-b64_cipher_length:]
        b64_decipher = bytes(map(lambda x: x - 47 if x >= 0x50 else x + 47, b64_cipher))
        b64 = base64.b64decode(b64_decipher)
        aes_key = fetch.headers["What"].encode("utf-8")
        aes_iv = "STOPSTOPSTOPSTOP".encode("utf-8")
        aes_counter = Counter.new(128, initial_value=int.from_bytes(aes_iv, "big"))
        aes = AES.new(aes_key, AES.MODE_CTR, counter=aes_counter)
        decrypted = aes.decrypt(b64).decode("utf-8")
        return JetLink(decrypted, headers={"Referer": url.address})
    