"""
    Plugin for ResolveURL
    Copyright (C) 2023 gujal

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

from resolveurl.plugins.__resolve_generic__ import ResolveGeneric
from resolveurl.lib import helpers


class GoodStreamResolver(ResolveGeneric):
    name = 'GoodStream'
    domains = ['goodstream.uno', 'goodstream.one']
    pattern = r'(?://|\.)(goodstream\.(?:uno|one))/(?:embed-|d/|e/|video/embed/)?([0-9a-zA-Z]+)'

    def get_media_url(self, host, media_id, subs=False):
        return helpers.get_media_url(
            self.get_url(host, media_id),
            patterns=[r'''sources:\s*\[{file:\s*["'](?P<url>[^"']+)'''],
            generic_patterns=False,
            subs=subs
        )

    def get_url(self, host, media_id):
        return self._default_get_url(host, media_id, template='https://{host}/embed-{media_id}.html')
