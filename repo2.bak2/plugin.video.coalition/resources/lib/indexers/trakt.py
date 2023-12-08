# -*- coding: utf-8 -*-
from sys import argv
from threading import Thread
from apis import trakt_api
from indexers.episodes import Episodes
from indexers.movies import Movies
from indexers.tvshows import TVShows
from indexers.seasons import build_season_list
from modules import kodi_utils
from modules.utils import paginate_list
from modules.settings import paginate, page_limit
# logger = kodi_utils.logger

KODI_VERSION, ls, tp = kodi_utils.get_kodi_version(), kodi_utils.local_string, kodi_utils.translatePath
make_listitem = kodi_utils.make_listitem
build_url = kodi_utils.build_url
trakt_icon = kodi_utils.translate_path('special://home/addons/plugin.video.coalition/resources/media/trakt.png')
fanart = kodi_utils.translate_path('special://home/addons/plugin.video.coalition/fanart.png')
item_jump, item_next = tp('special://home/addons/plugin.video.coalition/resources/media/item_jump.png'), tp('special://home/addons/plugin.video.coalition/resources/media/item_next.png')
add2menu_str, add2folder_str, likelist_str, unlikelist_str = ls(32730), ls(32731), ls(32776), ls(32783)
newlist_str, deletelist_str, nextpage_str, jump2_str = ls(32780), ls(32781), ls(32799), ls(32964)

def search_trakt_lists(params):
	def _builder():
		for item in lists:
			try:
				list_key = item['type']
				if list_key == 'officiallist': continue
				list_info = item[list_key]
				item_count = list_info['item_count']
				if list_info['privacy'] == 'private' or item_count == 0: continue
				name, user, slug = list_info['name'], list_info['username'], list_info['ids']['slug']
				share_link = list_info['share_link']
				plot = '[B]Link[/B]: [I]%s[/I]' % share_link
				cm = []
				cm_append = cm.append
				url = build_url({'mode': 'trakt.list.build_trakt_list', 'user': user, 'slug': slug})
				cm_append((add2menu_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.add_external', 'name': name, 'iconImage': 'trakt.png'})))
				cm_append((add2folder_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.shortcut_folder_add_item', 'name': name, 'iconImage': 'trakt.png'})))
				cm_append((likelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.trakt_like_a_list', 'user': user, 'list_slug': slug})))
				cm_append((unlikelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.trakt_unlike_a_list', 'user': user, 'list_slug': slug})))
				display = '[B]%s[/B] | [I](x%s) - %s[/I]' % (name.upper(), str(item_count), user)
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.setArt({'icon': trakt_icon, 'poster': trakt_icon, 'thumb': trakt_icon, 'fanart': fanart, 'banner': trakt_icon})
				listitem.addContextMenuItems(cm)
				if KODI_VERSION < 20:
					listitem.setInfo('video', {'plot': plot})
				else:
					videoinfo = listitem.getVideoInfoTag()
					videoinfo.setPlot(plot)
				yield (url, listitem, True)
			except: pass
	__handle__ = int(argv[1])
	mode = params.get('mode')
	page = params.get('new_page', '1')
	search_title = params.get('search_title', None) or kodi_utils.dialog.input('coalition')
	if not search_title: return
	lists, pages = trakt_api.trakt_search_lists(search_title, page)
	kodi_utils.add_items(__handle__, list(_builder()))
	if pages > page: kodi_utils.add_dir({'mode': mode, 'search_title': search_title, 'new_page': str(int(page) + 1)}, nextpage_str, __handle__, iconImage=item_next)
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.main')

def get_trakt_lists(params):
	def _process():
		def _make_display():
			if list_type == 'liked_lists': return '%s (x%s) - [I]%s[/I]' % (name, item_count, user) if item_count else '%s - [I]%s[/I]' % (name, user)
			else: return '%s (x%s)' % (name, item_count) if item_count else name
		for item in lists:
			try:
				if list_type == 'liked_lists': item = item['list']
				cm = []
				cm_append = cm.append
				name, user, slug = item['name'], item['user']['ids']['slug'], item['ids']['slug']
				item_count = item.get('item_count', None)
				display = _make_display()
				url = build_url({'mode': 'trakt.list.build_trakt_list', 'user': user, 'slug': slug, 'list_type': list_type})
				cm_append((add2menu_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.add_external', 'name': display, 'iconImage': 'trakt.png'})))
				cm_append((add2folder_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.shortcut_folder_add_item', 'name': display, 'iconImage': 'trakt.png'})))
				if list_type == 'liked_lists': cm_append((unlikelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.trakt_unlike_a_list', 'user': user, 'list_slug': slug})))
				else:
					cm_append((newlist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.make_new_trakt_list'})))
					cm_append((deletelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.delete_trakt_list', 'user': user, 'list_slug': slug})))
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.setArt({'icon': trakt_icon, 'poster': trakt_icon, 'thumb': trakt_icon, 'fanart': fanart, 'banner': trakt_icon})
				listitem.addContextMenuItems(cm, replaceItems=False)
				yield (url, listitem, True)
			except: pass
	__handle__ = int(argv[1])
	list_type = params['list_type']
	lists = trakt_api.trakt_get_lists(list_type)
	kodi_utils.add_items(__handle__, list(_process()))
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.set_sort_method(__handle__, 'label')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.main')

def get_trakt_trending_popular_lists(params):
	def _process():
		for item in lists:
			try:
				cm = []
				cm_append = cm.append
				item = item['list']
				name, user, slug = item['name'], item['user']['ids']['slug'], item['ids']['slug']
				updated, likes = item['updated_at'].replace('T', ' ').replace('.000', ' '), item['likes']
				share_link = item['share_link']
				plot = '[B]Link[/B]: [I]%s[/I][CR][CR][B]Updated[/B]: %s[CR][CR][B]Likes[/B]: %s' % (share_link, updated, likes)
				item_count = item.get('item_count', None)
				if item_count: display = '[B]%s[/B] | [I](x%s) - %s[/I]' % (name, item_count, user)
				else: display = '[B]%s[/B] | [I]%s[/I]' % (name, user)
				url = build_url({'mode': 'trakt.list.build_trakt_list', 'user': user, 'slug': slug, 'list_type': 'user_lists'})
				listitem = make_listitem()
				listitem.setLabel(display)
				listitem.setArt({'icon': trakt_icon, 'poster': trakt_icon, 'thumb': trakt_icon, 'fanart': fanart, 'banner': trakt_icon})
				if KODI_VERSION < 20:
					listitem.setInfo('video', {'plot': plot})
				else:
					videoinfo = listitem.getVideoInfoTag()
					videoinfo.setPlot(plot)
				cm_append((add2menu_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.add_external', 'name': name, 'iconImage': 'trakt.png'})))
				cm_append((add2folder_str,'RunPlugin(%s)' % build_url({'mode': 'menu_editor.shortcut_folder_add_item', 'name': name, 'iconImage': 'trakt.png'})))
				cm_append((likelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.trakt_like_a_list', 'user': user, 'list_slug': slug})))
				cm_append((unlikelist_str,'RunPlugin(%s)' % build_url({'mode': 'trakt.trakt_unlike_a_list', 'user': user, 'list_slug': slug})))
				listitem.addContextMenuItems(cm)
				yield (url, listitem, True)
			except: pass
	__handle__ = int(argv[1])
	list_type = params['list_type']
	lists = trakt_api.trakt_trending_popular_lists(list_type)
	kodi_utils.add_items(__handle__, list(_process()))
	kodi_utils.set_content(__handle__, 'files')
	kodi_utils.end_directory(__handle__)
	kodi_utils.set_view_mode('view.main')

def build_trakt_list(params):
	def _process(_type, items):
		if   _type == 'movies':
			item_list_extend(Movies({'id_type': 'trakt_dict', 'list': items}).worker())
		elif _type == 'tvshows':
			item_list_extend(TVShows({'id_type': 'trakt_dict', 'list': items}).worker())
		elif _type == 'episodes':
			item_list_extend(Episodes('trakt_dict', items).worker())
		elif _type == 'seasons':
			item_list_extend(build_season_list(dict({'mode': 'trakt_dict'}, **items)))
	def make_list(_list):
		for position, i in enumerate(_list):
			itype = i['type']
			if   itype == 'movie':
				item = ({'media_ids': dict(i[itype]['ids'], **{'sort': position}), 'title': i[itype]['title'], 'type': 'movies'})
			elif itype == 'show':
				item = ({'media_ids': dict(i[itype]['ids'], **{'sort': position}), 'title': i[itype]['title'], 'type': 'tvshows'})
			elif itype == 'episode':
				item = ({'media_ids': {'media_ids': {'tmdb': i['show']['ids']['tmdb']}, 'sort': position, 'season': i['episode']['season'],
									'episode': i['episode']['number']}, 'title': i['episode']['title'], 'type': 'episodes'})
			elif itype == 'season':
				item = ({'media_ids': {'tmdb_id': i['show']['ids']['tmdb'], 'sort': position, 'season': i['season']['number']},
									'title': i['season']['title'], 'type': 'seasons'})
			else: continue
			yield item
	try:
		__handle__, content = int(argv[1]), 'files'
		is_widget = kodi_utils.external_browse()
		user, slug, list_type = params.get('user'), params.get('slug'), params.get('list_type')
		letter, page_no = params.get('new_letter', 'None'), int(params.get('new_page', '1'))
		result = trakt_api.get_trakt_list_contents(list_type, user, slug)
		trakt_list = list(make_list(result))
		if paginate():
			limit = page_limit()
			process_list, total_pages = paginate_list(trakt_list, page_no, letter, limit)
		else: process_list, total_pages = trakt_list, 1
		if total_pages > 2 and not is_widget:
			kodi_utils.add_dir({'mode': 'build_navigate_to_page', 'transfer_mode': 'trakt.list.build_trakt_list', 'media_type': 'Media',
								'user': user, 'slug': slug, 'current_page': page_no, 'total_pages': total_pages, 'list_type': list_type},
								jump2_str, __handle__, iconImage=item_jump, isFolder=False)
		process_dict = {'movies': [], 'tvshows': [], 'seasons': [], 'episodes': []}
		for i in process_list: process_dict[i['type']] += [i['media_ids']]
		content = max(process_dict.items(), key=lambda x: len(x[1]))[0]
		item_list = []
		item_list_extend = item_list.extend
		threads = []
		threads += [Thread(target=_process, args=('movies', process_dict['movies']))]
		threads += [Thread(target=_process, args=('tvshows', process_dict['tvshows']))]
		threads += [Thread(target=_process, args=('episodes', process_dict['episodes']))]
		threads += [Thread(target=_process, args=('seasons', i)) for i in process_dict['seasons']]
		[i.start() for i in threads]
		[i.join() for i in threads]
		item_list.sort(key=lambda k: int(k[1].getProperty('coalition_sort_order')))
		kodi_utils.add_items(__handle__, item_list)
		if total_pages > page_no:
			kodi_utils.add_dir({'mode': 'trakt.list.build_trakt_list', 'user': user, 'slug': slug, 'new_page': str(page_no + 1), 'new_letter': letter, 'list_type': list_type},
								nextpage_str, __handle__, iconImage=item_next, isFolder=True)
	except: pass
	kodi_utils.set_content(__handle__, content)
	kodi_utils.end_directory(__handle__, False if is_widget else None)
	if params.get('refreshed'): kodi_utils.sleep(1000)
	kodi_utils.set_view_mode('view.%s' % content, content)

