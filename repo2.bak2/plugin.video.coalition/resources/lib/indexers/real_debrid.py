# -*- coding: utf-8 -*-
import sys
from apis.real_debrid_api import RealDebridAPI
from modules import kodi_utils
from modules.source_utils import supported_video_extensions
from modules.utils import clean_file_name, clean_title, normalize, jsondate_to_datetime
# from modules.kodi_utils import logger

ls = kodi_utils.local_string
make_listitem = kodi_utils.make_listitem
build_url = kodi_utils.build_url
default_rd_icon = kodi_utils.translate_path('special://home/addons/plugin.video.coalition/resources/media/realdebrid.png')
fanart = kodi_utils.translate_path('special://home/addons/plugin.video.coalition/fanart.png')
folder_str, file_str, delete_str, down_str = ls(32742).upper(), ls(32743).upper(), ls(32785), ls(32747)
extensions = supported_video_extensions()
RealDebrid = RealDebridAPI()

def rd_torrent_cloud():
	def _builder():
		for count, item in enumerate(my_cloud_files, 1):
			try:
				cm = []
				cm_append = cm.append
				display = '%02d | [B]%s[/B] | [I]%s [/I]' % (count, folder_str, clean_file_name(normalize(item['filename'])).upper())
				url_params = {'mode': 'real_debrid.browse_rd_cloud', 'id': item['id']}
				delete_params = {'mode': 'real_debrid.delete', 'id': item['id'], 'cache_type': 'torrent'}
				cm_append(('[B]%s %s[/B]' % (delete_str, folder_str.capitalize()),'RunPlugin(%s)' % build_url(delete_params)))
				url = build_url(url_params)
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.addContextMenuItems(cm)
				listitem.setArt({'icon': default_rd_icon, 'poster': default_rd_icon, 'thumb': default_rd_icon, 'fanart': fanart, 'banner': default_rd_icon})
				yield (url, listitem, True)
			except: pass
	try: my_cloud_files = [i for i in RealDebrid.user_cloud() if i['status'] == 'downloaded']
	except: my_cloud_files = []
	__handle__ = int(sys.argv[1])
	kodi_utils.add_items(__handle__, list(_builder()))
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.premium')

def rd_downloads():
	def _builder():
		for count, item in enumerate(my_downloads, 1):
			try:
				cm = []
				cm_append = cm.append
				datetime_object = jsondate_to_datetime(item['generated'], '%Y-%m-%dT%H:%M:%S.%fZ', remove_time=True)
				filename = item['filename']
				name = clean_file_name(filename).upper()
				size = float(int(item['filesize']))/1073741824
				display = '%02d | %.2f GB | %s  | [I]%s [/I]' % (count, size, datetime_object, name)
				url_link = item['download']
				url_params = {'mode': 'media_play', 'url': url_link, 'media_type': 'video'}
				down_file_params = {'mode': 'downloader', 'name': name, 'url': url_link,
									'action': 'cloud.realdebrid_direct', 'image': default_rd_icon}
				delete_params = {'mode': 'real_debrid.delete', 'id': item['id'], 'cache_type': 'download'}
				cm_append((down_str,'RunPlugin(%s)' % build_url(down_file_params)))
				cm_append(('[B]%s %s[/B]' % (delete_str, file_str.capitalize()),'RunPlugin(%s)' % build_url(delete_params)))
				url = build_url(url_params)
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.addContextMenuItems(cm)
				listitem.setArt({'icon': default_rd_icon, 'poster': default_rd_icon, 'thumb': default_rd_icon, 'fanart': fanart, 'banner': default_rd_icon})
				yield (url, listitem, True)
			except: pass
	try: my_downloads = [i for i in RealDebrid.downloads() if i['download'].lower().endswith(tuple(extensions))]
	except: my_downloads = []
	__handle__ = int(sys.argv[1])
	kodi_utils.add_items(__handle__, list(_builder()))
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.premium')

def browse_rd_cloud(folder_id):
	def _builder():
		for count, item in enumerate(pack_info, 1):
			try:
				cm = []
				name = item['path']
				if name.startswith('/'): name = name.split('/')[-1]
				name = clean_file_name(name).upper()
				url_link = item['url_link']
				if url_link.startswith('/'): url_link = 'http' + url_link
				size = float(int(item['bytes']))/1073741824
				display = '%02d | [B]%s[/B] | %.2f GB | [I]%s [/I]' % (count, file_str, size, name)
				url_params = {'mode': 'real_debrid.resolve_rd', 'url': url_link, 'play': 'true'}
				url = build_url(url_params)
				down_file_params = {'mode': 'downloader', 'name': name, 'url': url_link,
									'action': 'cloud.realdebrid', 'image': default_rd_icon}
				cm.append((down_str,'RunPlugin(%s)' % build_url(down_file_params)))
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.addContextMenuItems(cm)
				listitem.setArt({'icon': default_rd_icon, 'poster': default_rd_icon, 'thumb': default_rd_icon, 'fanart': fanart, 'banner': default_rd_icon})
				listitem.setInfo('video', {})
				yield (url, listitem, False)
			except: pass
	torrent_files = RealDebrid.user_cloud_info(folder_id)
	file_info = [i for i in torrent_files['files'] if i['path'].lower().endswith(tuple(extensions))]
	file_urls = torrent_files['links']
	for c, i in enumerate(file_info):
		try: i.update({'url_link': file_urls[c]})
		except: pass
	__handle__ = int(sys.argv[1])
	pack_info = sorted(file_info, key=lambda k: k['path'])
	kodi_utils.add_items(__handle__, list(_builder()))
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.premium')

def rd_external_browser(magnet, filtering_list):
	import re
	from html.parser import HTMLParser
	try:
		episode_match = False
		torrent_id = None
		torrent_keys = []
		append = torrent_keys.append
		magnet_url = HTMLParser().unescape(magnet)
		r = re.search(r'''magnet:.+?urn:([a-zA-Z0-9]+):([a-zA-Z0-9]+)''', str(magnet), re.I)
		infoHash = r.group(2).lower()
		torrent_files = RealDebrid.check_hash(infoHash)
		torrent_files = torrent_files[infoHash]['rd'][0]
		try: files_tuple = sorted([(k, v['filename'].lower()) for k,v in torrent_files.items() if v['filename'].lower().endswith(tuple(extensions))])
		except: return None
		files_tuple.sort()
		for i in files_tuple:
			if any(x in i[1] for x in filtering_list):
				episode_match = True
			append(i[0])
		if not episode_match: return None
		if not torrent_keys: return None
		torrent_keys = ','.join(torrent_keys)
		torrent = RealDebrid.add_magnet(magnet_url)
		torrent_id = torrent['id']
		RealDebrid.add_torrent_select(torrent_id, torrent_keys)
		torrent_files = RealDebrid.user_cloud_info(torrent_id)
		file_info = [i for i in torrent_files['files'] if i['path'].lower().endswith(tuple(extensions))]
		file_urls = torrent_files['links']
		pack_info = [dict(i.items() + [('url_link', file_urls[c])]) for c, i in enumerate(file_info)]
		pack_info.sort(key=lambda k: k['path'])
		for item in pack_info:
			filename = clean_title(item['path'])
			if any(x in filename for x in filtering_list):
				correct_result = item
				break
		url_link = correct_result['url_link']
		RealDebrid.delete_torrent(torrent_id)
		return resolve_rd({'url': url_link, 'play': 'false'})
	except:
		if torrent_id: RealDebrid.delete_torrent(torrent_id)
		return None

def rd_delete(file_id, cache_type):
	if not kodi_utils.confirm_dialog(): return
	if cache_type == 'torrent': result = RealDebrid.delete_torrent(file_id)
	else: result = RealDebrid.delete_download(file_id) # cache_type: 'download'
	if result.status_code in (401, 403, 404): return kodi_utils.notification(32574)
	RealDebrid.clear_cache()
	kodi_utils.execute_builtin('Container.Refresh')

def resolve_rd(params):
	url = params['url']
	resolved_link = RealDebrid.unrestrict_link(url)
	if params.get('play', 'false') != 'true' : return resolved_link
	from modules.player import coalitionPlayer
	coalitionPlayer().run(resolved_link, 'video')

def rd_account_info():
	from datetime import datetime
	from modules.utils import datetime_workaround
	try:
		kodi_utils.show_busy_dialog()
		account_info = RealDebrid.account_info()
		expires = datetime_workaround(account_info['expiration'], '%Y-%m-%dT%H:%M:%S.%fZ')
		days_remaining = (expires - datetime.today()).days
		body = []
		append = body.append
		append(ls(32758) % account_info['email'])
		append(ls(32755) % account_info['username'])
		append(ls(32757) % account_info['type'].capitalize())
		append(ls(32750) % expires)
		append(ls(32751) % days_remaining)
		append(ls(32759) % account_info['points'])
		kodi_utils.hide_busy_dialog()
		return kodi_utils.show_text(ls(32054).upper(), '\n\n'.join(body), font_size='large')
	except: kodi_utils.hide_busy_dialog()

