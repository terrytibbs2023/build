# -*- coding: utf-8 -*-
import sys
from threading import Thread
from indexers.metadata import movie_meta
from indexers.watched import get_watched_info_movie, get_watched_status_movie, get_resumetime, get_bookmarks
from modules import kodi_utils, settings
from modules.utils import manual_function_import, get_datetime, make_thread_list_enumerate, chunks
# logger = kodi_utils.logger

KODI_VERSION, make_cast_list = kodi_utils.get_kodi_version(), kodi_utils.make_cast_list
meta_function, get_datetime_function = movie_meta, get_datetime
resume_check_function, get_watched_function, get_watched_info_function = get_resumetime, get_watched_status_movie, get_watched_info_movie
string, ls, tp, get_infolabel = str, kodi_utils.local_string, kodi_utils.translate_path, kodi_utils.get_infolabel
build_url, remove_meta_keys, dict_removals = kodi_utils.build_url, kodi_utils.remove_meta_keys, kodi_utils.movie_dict_removals
metadata_user_info, watched_indicators, include_year_in_title = settings.metadata_user_info, settings.watched_indicators, settings.include_year_in_title
extras_open_action, get_art_provider, get_resolution = settings.extras_open_action, settings.get_art_provider, settings.get_resolution
tmdb_main = ('tmdb_movies_popular','tmdb_movies_blockbusters','tmdb_movies_in_theaters', 'tmdb_movies_upcoming', 'tmdb_movies_latest_releases','tmdb_movies_premieres')
trakt_main, trakt_personal = ('trakt_movies_trending', 'trakt_movies_most_watched', 'trakt_movies_top10_boxoffice'), ('trakt_collection', 'trakt_watchlist', 'trakt_collection_lists')
personal, imdb_personal = ('in_progress_movies', 'favourites_movies', 'watched_movies'), ('imdb_watchlist', 'imdb_user_list_contents', 'imdb_keywords_list_contents')
similar = ('tmdb_movies_similar', 'tmdb_movies_recommendations')
tmdb_special = ('tmdb_movies_languages', 'tmdb_movies_networks', 'tmdb_movies_year', 'tmdb_movies_certifications')
tmdb_special_key_dict = {'tmdb_movies_languages': 'language', 'tmdb_movies_networks': 'company', 'tmdb_movies_year': 'year', 'tmdb_movies_certifications': 'certification'}
personal_dict = {'in_progress_movies': ('indexers.watched', 'get_in_progress_movies'), 'favourites_movies': ('caches.favourites_cache', 'retrieve_favourites'),
				'watched_movies': ('indexers.watched', 'get_watched_items')}
run_plugin, container_refresh, container_update = 'RunPlugin(%s)', 'Container.Refresh(%s)', 'Container.Update(%s)'
item_jump, item_next = tp('special://home/addons/plugin.video.coalition/resources/media/item_jump.png'), tp('special://home/addons/plugin.video.coalition/resources/media/item_next.png')
poster_empty, fanart_empty = tp('special://home/addons/plugin.video.coalition/resources/media/box_office.png'), tp('special://home/addons/plugin.video.coalition/fanart.png')
watched_str, unwatched_str, traktmanager_str = ls(32642), ls(32643), ls(32198)
favmanager_str, extras_str, options_str, recomm_str = ls(32197), ls(32645), ls(32646), '[B]%s...[/B]' % ls(32503)
hide_str, exit_str, clearprog_str, play_str = ls(32648), ls(32649), ls(32651), '[B]%s...[/B]' % ls(32174)
nextpage_str, switchjump_str, jumpto_str = ls(32799), ls(32784), ls(32964)

class Movies:
	def __init__(self, params):
		self.params = params
		self.id_type, self.list, self.action = self.params.get('id_type', 'tmdb_id'), self.params.get('list', []), self.params.get('action', None)
		self.items, self.new_page, self.total_pages, self.exit_list_params, self.is_widget = [], {}, None, None, 'unchecked'

	def fetch_list(self):
		try:
			params_get = self.params.get
			self.is_widget = kodi_utils.external_browse()
			self.exit_list_params = params_get('exit_list_params', None) or get_infolabel('Container.FolderPath')
			self.handle = int(sys.argv[1])
			view_mode, content_type = 'view.movies', 'movies'
			mode = params_get('mode')
			try: page_no = int(params_get('new_page', '1'))
			except ValueError: page_no = params_get('new_page')
			letter = params_get('new_letter', 'None')
			if self.action in personal: var_module, import_function = personal_dict[self.action]
			else: var_module, import_function = 'apis.%s_api' % self.action.split('_')[0], self.action
			try: function = manual_function_import(var_module, import_function)
			except: pass
			if self.action in tmdb_main:
				data = function(page_no)
				self.list = [i['id'] for i in data['results']]
				total_pages = data['total_pages']
				if total_pages > page_no: self.new_page = {'new_page': string(data['page'] + 1)}
			elif self.action in trakt_main:
				self.id_type = 'trakt_dict'
				data = function(page_no)
				self.list = [i['movie']['ids'] for i in data]
				if self.action not in ('trakt_movies_top10_boxoffice'): self.new_page = {'new_page': string(page_no + 1)}
			elif self.action in trakt_personal:
				self.id_type = 'trakt_dict'
				data, total_pages = function('movies', page_no, letter)
				self.list = [i['media_ids'] for i in data]
				if total_pages > 2: self.total_pages = total_pages
				try:
					if total_pages > page_no: self.new_page = {'new_page': string(page_no + 1), 'new_letter': letter}
				except: pass
			elif self.action in imdb_personal:
				self.id_type = 'imdb_id'
				list_id = params_get('list_id', None)
				data, next_page = function('movie', list_id, page_no)
				self.list = [i['imdb_id'] for i in data]
				if next_page: self.new_page = {'list_id': list_id, 'new_page': string(page_no + 1), 'new_letter': letter}
			elif self.action in personal:
				data, total_pages = function('movie', page_no, letter)
				self.list = [i['media_id'] for i in data]
				if total_pages > 2: self.total_pages = total_pages
				if total_pages > page_no: self.new_page = {'new_page': string(page_no + 1), 'new_letter': letter}
			elif self.action in similar:
				tmdb_id = params_get('tmdb_id')
				data = function(tmdb_id, page_no)
				self.list = [i['id'] for i in data['results']]
				if data['page'] < data['total_pages']: self.new_page = {'new_page': string(data['page'] + 1), 'tmdb_id': tmdb_id}
			elif self.action in tmdb_special:
				key = tmdb_special_key_dict[self.action]
				function_var = params_get(key, None)
				if not function_var: return
				data = function(function_var, page_no)
				self.list = [i['id'] for i in data['results']]
				if data['page'] < data['total_pages']: self.new_page = {'new_page': string(data['page'] + 1), key: function_var}
			elif self.action == 'tmdb_movies_discover':
				from indexers.discover import set_history
				name, query = params_get('name'), params_get('query')
				if page_no == 1: set_history('movie', name, query)
				data = function(query, page_no)
				self.list = [i['id'] for i in data['results']]
				if data['page'] < data['total_pages']: self.new_page = {'query': query, 'name': name, 'new_page': string(data['page'] + 1)}
			elif self.action == 'imdb_movies_oscar_winners':
				from modules.meta_lists import oscar_winners
				self.list = [i for i in chunks(oscar_winners, 20)][page_no-1]
				if self.list[-1] != 631: self.new_page = {'new_page': string(page_no + 1)}
			elif self.action == 'tmdb_movies_genres':
				genre_id = params_get('genre_id')
				if not genre_id: return
				data = function(genre_id, page_no)
				self.list = [i['id'] for i in data['results']]
				if data['page'] < data['total_pages']: self.new_page = {'new_page': string(data['page'] + 1), 'genre_id': genre_id}
			elif self.action  == 'tmdb_movies_search':
				query = params_get('query')
				data = function(query, page_no)
				self.list = [i['id'] for i in data['results']]
				total_pages = data['total_pages']
				if total_pages > page_no: self.new_page = {'new_page': string(page_no + 1), 'new_letter': letter, 'query': query}
			elif self.action  == 'tmdb_movies_search_collections':
				self.builder, view_mode, content_type = self.build_collections_results, 'view.main', ''
				query = params_get('query')
				data = function(query, page_no)
				self.list = data['results']
				total_pages = data['total_pages']
				if total_pages > page_no: self.new_page = {'new_page': string(page_no + 1), 'query': query}
			elif self.action  == 'tmdb_movies_collection':
				data = sorted(function(params_get('collection_id'))['parts'], key=lambda k: k['release_date'] or '2050')
				self.list = [i['id'] for i in data]
			elif self.action == 'trakt_recommendations':
				self.id_type = 'trakt_dict'
				data = function('movies')
				self.list = [i['ids'] for i in data]
			if self.total_pages and not self.is_widget:
				url_params = {'mode': 'build_navigate_to_page', 'media_type': 'Movies', 'current_page': page_no, 'total_pages': self.total_pages, 'transfer_mode': mode,
							'transfer_action': self.action, 'query': params_get('search_name', ''), 'actor_id': params_get('actor_id', '')}
				kodi_utils.add_dir(url_params, jumpto_str, self.handle, item_jump, isFolder=False)
			kodi_utils.add_items(self.handle, self.worker())
			if self.new_page:
				self.new_page.update({'mode': mode, 'action': self.action, 'exit_list_params': self.exit_list_params})
				kodi_utils.add_dir(self.new_page, nextpage_str, self.handle, item_next)
		except: pass
		kodi_utils.set_content(self.handle, content_type)
		kodi_utils.end_directory(self.handle, False if self.is_widget else None)
		kodi_utils.set_view_mode(view_mode, content_type)

	def build_movie_content(self, item_position, _id):
		try:
			meta = meta_function(self.id_type, _id, self.meta_user_info, self.current_date)
			meta_get = meta.get
			if not meta or meta_get('blank_entry', False): return
			playcount, overlay = get_watched_function(self.watched_info, string(meta['tmdb_id']))
			meta.update({'playcount': playcount, 'overlay': overlay})
			sort = _id['sort'] if self.id_type == 'trakt_dict' and 'sort' in _id else ''
			cm = []
			cm_append = cm.append
			listitem = kodi_utils.make_listitem()
			set_property = listitem.setProperty
			clearprog_params, unwatched_params, watched_params = '', '', ''
			rootname, title, year = meta_get('rootname'), meta_get('title'), meta_get('year')
			tmdb_id, imdb_id = meta_get('tmdb_id'), meta_get('imdb_id')
			poster = meta_get(self.poster_main) or meta_get(self.poster_backup) or poster_empty
			fanart = meta_get(self.fanart_main) or meta_get(self.fanart_backup) or fanart_empty
			clearlogo = meta_get('clearlogo') or meta_get('tmdblogo') or ''
			resumetime = resume_check_function(self.bookmarks, tmdb_id)
			play_params = build_url({'mode': 'play_media', 'media_type': 'movie', 'tmdb_id': tmdb_id})
			extras_params = build_url({'mode': 'extras_menu_choice', 'tmdb_id': tmdb_id, 'media_type': 'movie', 'is_widget': self.is_widget})
			options_params = build_url({'mode': 'options_menu_choice', 'content': 'movie', 'tmdb_id': tmdb_id})
			recommended_params = build_url({'mode': 'build_movie_list', 'action': 'tmdb_movies_recommendations', 'tmdb_id': tmdb_id})
			trakt_manager_params = build_url({'mode': 'trakt_manager_choice', 'tmdb_id': tmdb_id, 'imdb_id': imdb_id, 'tvdb_id': 'None', 'media_type': 'movie'})
			fav_manager_params = build_url({'mode': 'favorites_choice', 'media_type': 'movie', 'tmdb_id': tmdb_id, 'title': title})
			if self.fanart_enabled:
				banner, clearart, landscape, discart = meta_get('banner'), meta_get('clearart'), meta_get('landscape'), meta_get('discart')
			else: banner, clearart, landscape, discart = '', '', '', ''
			cm_append((options_str, run_plugin % options_params))
			if self.open_extras:
				url_params = extras_params
				cm_append((play_str, run_plugin % play_params))
			else:
				url_params = play_params
				cm_append((extras_str, run_plugin % extras_params))
			cm_append((traktmanager_str, run_plugin % trakt_manager_params))
			cm_append((favmanager_str, run_plugin % fav_manager_params))
			if resumetime != '0':
				clearprog_params = build_url({'mode': 'watched_unwatched_erase_bookmark', 'media_type': 'movie', 'tmdb_id': tmdb_id, 'refresh': 'true'})
				cm_append((clearprog_str, run_plugin % clearprog_params))
				set_property('coalition_in_progress', 'true')
			if playcount:
				if self.widget_hide_watched: return
				unwatched_params = build_url({'mode': 'mark_as_watched_unwatched_movie', 'action': 'mark_as_unwatched', 'tmdb_id': tmdb_id, 'title': title, 'year': year})
				cm_append((unwatched_str % self.watched_title, run_plugin % unwatched_params))
			else:
				watched_params = build_url({'mode': 'mark_as_watched_unwatched_movie', 'action': 'mark_as_watched', 'tmdb_id': tmdb_id, 'title': title, 'year': year})
				cm_append((watched_str % self.watched_title, run_plugin % watched_params))
			cm_append((exit_str, container_refresh % self.exit_list_params))
			listitem.setLabel(rootname if self.include_year_in_title else title)
			listitem.setContentLookup(False)
			listitem.addContextMenuItems(cm)
			listitem.setArt({'poster': poster, 'fanart': fanart, 'icon': poster, 'banner': banner, 'clearart': clearart,
							'clearlogo': clearlogo, 'landscape': landscape, 'discart': discart})
			if KODI_VERSION < 20:
				listitem.setCast(meta_get('cast', []))
				listitem.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id)})
				listitem.setInfo('video', remove_meta_keys(meta, dict_removals))
				set_property('resumetime', resumetime)
			else:
				videoinfo = listitem.getVideoInfoTag()
				videoinfo.setCast(make_cast_list(meta_get('cast', [])))
				videoinfo.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id)})
				videoinfo.setCountries(meta_get('country'))
				videoinfo.setDirectors(meta_get('director').split(', '))
				videoinfo.setDuration(int(meta_get('duration')))
				videoinfo.setGenres(meta_get('genre').split(', '))
				videoinfo.setIMDBNumber(imdb_id)
				videoinfo.setMediaType('movie')
				videoinfo.setMpaa(meta_get('mpaa'))
				videoinfo.setPlaycount(playcount)
				videoinfo.setPlot(meta_get('plot'))
				videoinfo.setPremiered(meta_get('premiered'))
				videoinfo.setRating(meta_get('rating'))
				videoinfo.setResumePoint(float(resumetime))
				videoinfo.setStudios((meta_get('studio'),))
				videoinfo.setTagLine(meta_get('tagline'))
				videoinfo.setTitle(title)
				videoinfo.setTrailer(meta_get('trailer'))
				videoinfo.setVotes(meta_get('votes'))
				videoinfo.setWriters(meta_get('writer').split(', '))
				videoinfo.setYear(int(year or 0))
			set_property('coalition_sort_order', string(sort or item_position))
			if self.is_widget:
				set_property('coalition_widget', 'true')
				set_property('coalition_playcount', string(playcount))
				set_property('coalition_extras_menu_params', extras_params)
				set_property('coalition_options_menu_params', options_params)
				set_property('coalition_trakt_manager_params', trakt_manager_params)
				set_property('coalition_fav_manager_params', fav_manager_params)
				set_property('coalition_unwatched_params', unwatched_params)
				set_property('coalition_watched_params', watched_params)
				set_property('coalition_clearprog_params', clearprog_params)
			else: set_property('coalition_widget', 'false')
			self.append((url_params, listitem, False))
		except: pass

	def worker(self):
		self.current_date = get_datetime_function()
		self.meta_user_info = metadata_user_info()
		self.watched_indicators = watched_indicators()
		self.watched_info = get_watched_info_function(self.watched_indicators)
		self.bookmarks = get_bookmarks(self.watched_indicators, 'movie')
		self.include_year_in_title = include_year_in_title('movie')
		self.open_extras = extras_open_action('movie')
		self.fanart_enabled = self.meta_user_info['extra_fanart_enabled']
		if self.is_widget == 'unchecked': self.is_widget = kodi_utils.external_browse()
		self.widget_hide_watched = self.is_widget and self.meta_user_info['widget_hide_watched']
		if not self.exit_list_params: self.exit_list_params = get_infolabel('Container.FolderPath')
		self.watched_title = 'Trakt' if self.watched_indicators == 1 else 'coalition'
		self.poster_main, self.poster_backup, self.fanart_main, self.fanart_backup = get_art_provider()
		self.append = self.items.append
		threads = list(make_thread_list_enumerate(self.build_movie_content, self.list, Thread))
		[i.join() for i in threads]
		self.items.sort(key=lambda k: int(k[1].getProperty('coalition_sort_order')))
		return self.items

	def build_collections_results(self):
		def _process():
			for item in self.list:
				url_params = build_url({'mode': 'build_movie_list', 'action': 'tmdb_movies_collection', 'collection_id':item['id'] })
				poster_path, backdrop_path = item['poster_path'], item['backdrop_path']
				if poster_path: poster = tmdb_image_url % (image_resolution['poster'], poster_path)
				else: poster = poster_empty
				if backdrop_path: fanart = tmdb_image_url % (image_resolution['fanart'], backdrop_path)
				else: fanart = fanart_empty
				listitem = kodi_utils.make_listitem()
				listitem.setLabel(item['name'])
				listitem.setInfo('Video', {'plot': item['overview']})
				listitem.setArt({'icon': poster, 'fanart': fanart})
				yield (url_params, listitem, True)
		image_resolution = get_resolution()
		tmdb_image_url = 'https://image.tmdb.org/t/p/%s%s'
		self.items = list(_process())
		return self.items

