"""
    Plugin for ResolveUrl
    Copyright (C) 2024 MrDini123 (github.com/movieshark)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

from resolveurl.lib import helpers
from resolveurl import common
from resolveurl.resolver import ResolveUrl, ResolverError


class DzenResolver(ResolveUrl):
    name = 'dzen'
    domains = ['dzen.ru']
    pattern = r'(?://|\.)(dzen\.ru)/((?:video/watch|embed)/[0-9a-zA-Z_]+)'

    def get_media_url(self, host, media_id):
        web_url = self.get_url(host, media_id)
        headers = {'User-Agent': common.RAND_UA,
                   'Cookie': 'zen_sso_checked=1; zen_vk_sso_checked=1'}
        html = self.net.http_GET(web_url, headers=headers).content
        sources = helpers.scrape_sources(
            html,
            patterns=[r'''(?P<url>https://[^\"']+\.m3u8[^"]*)'''],
            generic_patterns=False
        )
        if sources:
            headers.pop('Cookie')
            return helpers.pick_source(sources) + helpers.append_headers(headers)
        raise ResolverError('No video found')

    def get_url(self, host, media_id):
        return self._default_get_url(host, media_id, template='https://{host}/{media_id}')
