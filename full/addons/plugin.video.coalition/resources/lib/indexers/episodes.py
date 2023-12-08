# -*- coding: utf-8 -*-
import sys
from threading import Thread
from apis.trakt_api import trakt_fetch_collection_watchlist, trakt_get_hidden_items, trakt_get_my_calendar
from indexers.metadata import tvshow_meta, season_episodes_meta, all_episodes_meta
from indexers.watched import get_resumetime, get_watched_status_episode, get_watched_info_tv, get_bookmarks, get_next_episodes, get_in_progress_episodes
from modules import kodi_utils, settings
from modules.utils import jsondate_to_datetime, adjust_premiered_date, make_day, get_datetime, title_key, date_difference, make_thread_list_enumerate
# logger = kodi_utils.logger

KODI_VERSION, make_cast_list, remove_meta_keys = kodi_utils.get_kodi_version(), kodi_utils.make_cast_list, kodi_utils.remove_meta_keys
ls, tp, build_url, dict_removals = kodi_utils.local_string, kodi_utils.translate_path, kodi_utils.build_url, kodi_utils.episode_dict_removals
get_art_provider, show_specials, calendar_sort_order, ignore_articles = settings.get_art_provider, settings.show_specials, settings.calendar_sort_order, settings.ignore_articles
nextep_content_settings, nextep_display_settings, calendar_focus_today = settings.nextep_content_settings, settings.nextep_display_settings, settings.calendar_focus_today
thumb_fanart_info, date_offset_info, default_all_episodes = settings.thumb_fanart, settings.date_offset, settings.default_all_episodes
single_ep_display_title, single_ep_format = settings.single_ep_display_title, settings.single_ep_format
tv_meta_function, season_meta_function, all_episodes_meta_function = tvshow_meta, season_episodes_meta, all_episodes_meta
adjust_premiered_date_function, jsondate_to_datetime_function = adjust_premiered_date, jsondate_to_datetime
date_difference_function, make_day_function, title_key_function, get_datetime_function = date_difference, make_day, title_key, get_datetime
get_watched_status, get_watched_info = get_watched_status_episode, get_watched_info_tv
string, watched_str, unwatched_str, extras_str, options_str = str, ls(32642), ls(32643), ls(32645), ls(32646)
upper, clearprog_str, browse_str, browse_seas_str, nextep_manager_str = string.upper, ls(32651), ls(32652), ls(32544), ls(32599)
poster_empty, fanart_empty = tp('special://home/addons/plugin.video.coalition/resources/media/box_office.png'), tp('special://home/addons/plugin.video.coalition/fanart.png')
run_plugin, container_update, unaired_label = 'RunPlugin(%s)', 'Container.Update(%s)', '[COLOR cyan][I]%s[/I][/COLOR]'

class Episodes:
	def __init__(self, list_type, data):
		self.list_type, self.list = list_type, data
		self.items = []

	def build_single_episode(self):
		__handle__ = int(sys.argv[1])
		kodi_utils.add_items(__handle__, self.worker())
		kodi_utils.set_content(__handle__, 'episodes')
		kodi_utils.end_directory(__handle__, cacheToDisc=False)
		kodi_utils.set_view_mode('view.episodes', 'episodes')
		if self.list_type == 'trakt_calendar' and calendar_focus_today():
			today = '[%s]' % ls(32849).upper()
			try: index = max([i for i, x in enumerate([i[1].getLabel() for i in item_list]) if today in x])
			except: return
			kodi_utils.focus_index(index)

	def build_episode_content(self, item_position, ep_data):
		try:
			cm = []
			listitem = kodi_utils.make_listitem()
			set_property = listitem.setProperty
			cm_append = cm.append
			ep_data_get = ep_data.get
			meta = tv_meta_function('trakt_dict', ep_data_get('media_ids'), self.meta_user_info, self.current_date)
			if not meta: return
			meta_get = meta.get
			tmdb_id, tvdb_id, imdb_id = meta_get('tmdb_id'), meta_get('tvdb_id'), meta_get('imdb_id')
			title, year, rootname, show_status = meta_get('title'), meta_get('year'), meta_get('rootname'), meta_get('status')
			show_poster = meta_get(self.poster_main) or meta_get(self.poster_backup) or poster_empty
			fanart = meta_get(self.fanart_main) or meta_get(self.fanart_backup) or fanart_empty
			clearlogo = meta_get('clearlogo') or meta_get('tmdblogo') or ''
			if self.fanart_enabled: banner, clearart, landscape = meta_get('banner'), meta_get('clearart'), meta_get('landscape')
			else: banner, clearart, landscape = '', '', ''
			cast, mpaa, duration, tvshow_plot = meta_get('cast', []), meta_get('mpaa'), meta_get('duration'), meta_get('plot')
			trailer, genre, studio = string(meta_get('trailer')), meta_get('genre'), meta_get('studio')
			orig_season, orig_episode = ep_data_get('season'), ep_data_get('episode')
			if self.list_type_starts_with('next_episode'):
				season_data = meta_get('season_data')
				curr_season_data = [i for i in season_data if i['season_number'] == orig_season][0]
				if orig_episode >= curr_season_data['episode_count']: orig_season, orig_episode, new_season = orig_season + 1, 1, True
				else: orig_episode, new_season = orig_episode + 1, False
			episodes_data = season_meta_function(orig_season, meta, self.meta_user_info)
			try: item = [i for i in episodes_data if i['episode'] == orig_episode][0]
			except: return
			item_get = item.get
			season, episode, ep_name = item_get('season'), item_get('episode'), item_get('title')
			str_season_zfill2, str_episode_zfill2 = string(season).zfill(2), string(episode).zfill(2)
			orig_premiered = item_get('premiered')
			episode_date, premiered = adjust_premiered_date_function(orig_premiered, self.adjust_hours)
			if not episode_date or self.current_date < episode_date:
				if self.list_type_starts_with('next_episode'):
					if not self.nextep_include_unaired: return
					if episode_date and new_season and not date_difference_function(self.current_date, episode_date, 7): return
				elif not self.show_unaired: return
				unaired = True
				set_property('coalition_unaired', 'true')
			else:
				unaired = False
				set_property('coalition_unaired', 'false')
			playcount, overlay = get_watched_status(self.watched_info, string(tmdb_id), season, episode)
			resumetime = get_resumetime(self.bookmarks, tmdb_id, season, episode)
			if self.display_title == 0: title_string = ''.join([title, ': '])
			else: title_string = ''
			if self.display_title in (0,1): seas_ep = ''.join([str_season_zfill2, 'x', str_episode_zfill2, ' - '])
			else: seas_ep = ''
			if self.list_type_starts_with('next_episode'):
				unwatched = ep_data_get('unwatched', False)
				if episode_date: display_premiered = make_day_function(self.current_date, episode_date, self.date_format)
				else: display_premiered == 'UNKNOWN'
				airdate = ''.join(['[[COLOR magenta]', display_premiered, '[/COLOR]] ']) if self.nextep_include_airdate else ''
				highlight_color = self.nextep_unaired_color if unaired else self.nextep_unwatched_color if unwatched else ''
				italics_open, italics_close = ('[I]', '[/I]') if highlight_color else ('', '')
				if highlight_color: episode_info = ''.join([italics_open, '[COLOR', highlight_color, ']', seas_ep, ep_name, '[/COLOR]', italics_close])
				else: episode_info = ''.join([italics_open, seas_ep, ep_name, italics_close])
				display = ''.join([airdate, upper(title_string), episode_info])
			elif self.list_type == 'trakt_calendar':
				if episode_date: display_premiered = make_day_function(self.current_date, episode_date, self.date_format)
				else: display_premiered == 'UNKNOWN'
				display = ''.join(['[', display_premiered, '] ', upper(title_string), seas_ep, ep_name])
				if unaired:
					displays = display.split(']')
					display = ''.join(['[COLOR cyan]', displays[0], '][/COLOR]', displays[1]])
			else:
				color_tags = ('[COLOR cyan]', '[/COLOR]') if unaired else ('', '')
				display = ''.join([upper(title_string), color_tags[0], seas_ep, ep_name, color_tags[1]])
			thumb = item_get('thumb', None) or fanart
			if self.thumb_fanart: background = thumb
			else: background = fanart
			item.update({'trailer': trailer, 'tvshowtitle': title, 'premiered': premiered, 'genre': genre, 'duration': duration,
						'mpaa': mpaa, 'studio': studio, 'playcount': playcount, 'overlay': overlay, 'title': display})
			extras_params = build_url({'mode': 'extras_menu_choice', 'tmdb_id': tmdb_id, 'media_type': 'tvshow', 'is_widget': self.is_widget})
			options_params = build_url({'mode': 'options_menu_choice', 'content': 'episode', 'tmdb_id': tmdb_id, 'season': season, 'episode': episode})
			url_params = build_url({'mode': 'play_media', 'media_type': 'episode', 'tmdb_id': tmdb_id, 'season': season, 'episode': episode})
			if self.show_all_episodes:
				if self.all_episodes == 1 and meta_get('total_seasons') > 1: browse_params = build_url({'mode': 'build_season_list', 'tmdb_id': tmdb_id})
				else: browse_params = build_url({'mode': 'build_episode_list', 'tmdb_id': tmdb_id, 'season': 'all'})
			else: browse_params = build_url({'mode': 'build_season_list', 'tmdb_id': tmdb_id})
			browse_seas_params = build_url({'mode': 'build_episode_list', 'tmdb_id': tmdb_id, 'season': season})
			cm_append((options_str, run_plugin % options_params))
			cm_append((extras_str, run_plugin % extras_params))
			cm_append((browse_str, container_update % browse_params))
			cm_append((browse_seas_str, container_update % browse_seas_params))
			clearprog_params, unwatched_params, watched_params = '', '', ''
			if not unaired:
				if resumetime != '0':
					clearprog_params = build_url({'mode': 'watched_unwatched_erase_bookmark', 'media_type': 'episode', 'tmdb_id': tmdb_id,
												'season': season, 'episode': episode, 'refresh': 'true'})
					cm_append((clearprog_str, run_plugin % clearprog_params))
					set_property('coalition_in_progress', 'true')
				if playcount:
					if self.hide_watched: return
					unwatched_params = build_url({'mode': 'mark_as_watched_unwatched_episode', 'action': 'mark_as_unwatched', 'tmdb_id': tmdb_id,
												'tvdb_id': tvdb_id, 'season': season, 'episode': episode,  'title': title, 'year': year})
					cm_append((unwatched_str % self.watched_title, run_plugin % unwatched_params))
				else:
					watched_params = build_url({'mode': 'mark_as_watched_unwatched_episode', 'action': 'mark_as_watched', 'tmdb_id': tmdb_id,
												'tvdb_id': tvdb_id, 'season': season, 'episode': episode,  'title': title, 'year': year})
					cm_append((watched_str % self.watched_title, run_plugin % watched_params))
			if self.list_type == 'next_episode_trakt': cm_append((nextep_manager_str, container_update % build_url({'mode': 'build_next_episode_manager'})))
			listitem.setLabel(display)
			listitem.setContentLookup(False)
			listitem.addContextMenuItems(cm)
			listitem.setArt({'poster': show_poster, 'fanart': background, 'thumb': thumb, 'icon':thumb, 'banner': banner, 'clearart': clearart, 'clearlogo': clearlogo,
							'landscape': thumb, 'tvshow.clearart': clearart, 'tvshow.clearlogo': clearlogo, 'tvshow.landscape': thumb, 'tvshow.banner': banner})
			if KODI_VERSION < 20:
				listitem.setCast(cast + item_get('guest_stars', []))
				listitem.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id), 'tvdb': string(tvdb_id)})
				listitem.setInfo('video', remove_meta_keys(item, dict_removals))
				set_property('resumetime', resumetime)
			else:
				videoinfo = listitem.getVideoInfoTag()
				videoinfo.setCast(make_cast_list(cast + item_get('guest_stars', [])))
				videoinfo.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id), 'tvdb': string(tvdb_id)})
				videoinfo.setDirectors(item_get('director').split(', '))
				videoinfo.setDuration(item_get('duration'))
				videoinfo.setEpisode(episode)
				videoinfo.setFirstAired(item_get('premiered'))
				videoinfo.setGenres(genre.split(', '))
				videoinfo.setIMDBNumber(imdb_id)
				videoinfo.setMediaType('episode')
				videoinfo.setMpaa(mpaa)
				videoinfo.setPlaycount(playcount)
				videoinfo.setPlot(item_get('plot'))
				videoinfo.setRating(item_get('rating'))
				videoinfo.setResumePoint(float(resumetime))
				videoinfo.setSeason(season)
				videoinfo.setStudios((studio,))
				videoinfo.setTitle(item_get('title'))
				videoinfo.setTrailer(trailer)
				videoinfo.setTvShowStatus(show_status)
				videoinfo.setTvShowTitle(title)
				videoinfo.setVotes(item_get('votes'))
				videoinfo.setWriters(item_get('writer').split(', '))
				videoinfo.setYear(int(year))
			set_property('coalition_name', '%s - %sx%s' % (title, str_season_zfill2, str_episode_zfill2))
			set_property('coalition_first_aired', premiered)
			if self.list_type_starts_with('next_episode'):
				last_played = ep_data_get('last_played', self.resinsert)
				set_property('coalition_last_played', last_played)
			else: set_property('coalition_sort_order', string(ep_data_get('sort', item_position)))
			if self.is_widget:
				set_property('coalition_widget', 'true')
				set_property('coalition_playcount', string(playcount))
				set_property('coalition_browse_params', browse_params)
				set_property('coalition_browse_seas_params', browse_seas_params)
				set_property('coalition_options_menu_params', options_params)
				set_property('coalition_extras_menu_params', extras_params)
				set_property('coalition_unwatched_params', unwatched_params)
				set_property('coalition_watched_params', watched_params)
				set_property('coalition_clearprog_params', clearprog_params)
			else: set_property('coalition_widget', 'false')
			self.append((url_params, listitem, False))
		except: pass

	def worker(self):
		def _sort_results(items):
			if self.list_type_starts_with('next_episode'):
				def func(function):
					if sort_key == 'coalition_name': return title_key_function(function, ignore_articles_setting)
					elif sort_key == 'coalition_last_played': return jsondate_to_datetime_function(function, resformat)
					else: return function
				sort_key = nextep_settings['sort_key']
				sort_direction = nextep_settings['sort_direction']
				if nextep_settings['sort_airing_today_to_top']:
					airing_today = [i for i in items
									if date_difference_function(self.current_date, jsondate_to_datetime_function(i[1].getProperty('coalition_first_aired'), '%Y-%m-%d').date(), 0)]
					airing_today = sorted(airing_today, key=lambda i: i[1].getProperty('coalition_first_aired'))
					remainder = [i for i in items if not i in airing_today]
					remainder = sorted(remainder, key=lambda i: func(i[1].getProperty(sort_key)), reverse=sort_direction)
					unaired = [i for i in remainder if i[1].getProperty('coalition_unaired') == 'true']
					aired = [i for i in remainder if not i in unaired]
					remainder = aired + unaired
					items = airing_today + remainder
				else:
					items = sorted(items, key=lambda i: func(i[1].getProperty(sort_key)), reverse=sort_direction)
					unaired = [i for i in items if i[1].getProperty('coalition_unaired') == 'true']
					aired = [i for i in items if not i in unaired]
					items = aired + unaired
			else:
				items.sort(key=lambda k: int(k[1].getProperty('coalition_sort_order')))
				if self.list_type in ('trakt_calendar', 'trakt_recently_aired'):
					if self.list_type == 'trakt_calendar': reverse = calendar_sort_order() == 0
					else: reverse = True
					items.sort(key=lambda k: int(k[1].getProperty('coalition_sort_order')))
					items = sorted(items, key=lambda i: i[1].getProperty('coalition_first_aired'), reverse=reverse)
			return items
		self.list_type_starts_with = self.list_type.startswith
		self.meta_user_info = settings.metadata_user_info()
		self.watched_indicators = settings.watched_indicators()
		self.watched_info = get_watched_info(self.watched_indicators)
		self.show_unaired = settings.show_unaired()
		self.thumb_fanart = thumb_fanart_info()
		self.is_widget = kodi_utils.external_browse()
		self.fanart_enabled = self.meta_user_info['extra_fanart_enabled']
		self.hide_watched = self.is_widget and self.meta_user_info['widget_hide_watched']
		self.current_date = get_datetime_function()
		self.adjust_hours = date_offset_info()
		self.bookmarks = get_bookmarks(self.watched_indicators, 'episode')
		self.display_title, self.date_format = single_ep_display_title(), single_ep_format()
		self.all_episodes = default_all_episodes()
		self.show_all_episodes = self.all_episodes in (1, 2)
		self.poster_main, self.poster_backup, self.fanart_main, self.fanart_backup = get_art_provider()
		ignore_articles_setting = ignore_articles()
		self.watched_title = 'Trakt' if self.watched_indicators == 1 else 'coalition'
		if self.list_type_starts_with('next_episode'):
			nextep_settings, nextep_disp_settings = nextep_content_settings(), nextep_display_settings()
			self.nextep_unaired_color, self.nextep_unwatched_color = nextep_disp_settings['unaired_color'], nextep_disp_settings['unwatched_color']
			self.nextep_include_airdate, self.nextep_include_unaired = nextep_disp_settings['include_airdate'], nextep_settings['include_unaired']
			if self.watched_indicators == 1: resformat, self.resinsert = '%Y-%m-%dT%H:%M:%S.%fZ', '2000-01-01T00:00:00.000Z'
			else: resformat, self.resinsert = '%Y-%m-%d %H:%M:%S', '2000-01-01 00:00:00'
		self.append = self.items.append
		threads = list(make_thread_list_enumerate(self.build_episode_content, self.list, Thread))
		[i.join() for i in threads]
		if self.list_type != 'trakt_dict': self.items = _sort_results(self.items)
		return self.items

def build_episode_list(params):
	def _process():
		for item in episodes_data:
			try:
				cm = []
				listitem = kodi_utils.make_listitem()
				set_property = listitem.setProperty
				cm_append = cm.append
				item_get = item.get
				season, episode, ep_name = item_get('season'), item_get('episode'), item_get('title')
				premiered = item_get('premiered')
				episode_date, premiered = adjust_premiered_date_function(premiered, adjust_hours)
				playcount, overlay = get_watched_status(watched_info, string(tmdb_id), season, episode)
				resumetime = get_resumetime(bookmarks, tmdb_id, season, episode)
				thumb = item_get('thumb', None) or fanart
				if thumb_fanart: background = thumb
				else: background = fanart
				item.update({'trailer': trailer, 'tvshowtitle': title, 'premiered': premiered, 'genre': genre, 'duration': duration, 'mpaa': mpaa, 'studio': studio,
							'playcount': playcount, 'overlay': overlay})
				extras_params = build_url({'mode': 'extras_menu_choice', 'tmdb_id': tmdb_id, 'media_type': 'tvshow', 'is_widget': is_widget})
				options_params = build_url({'mode': 'options_menu_choice', 'content': 'episode', 'tmdb_id': tmdb_id, 'season': season, 'episode': episode})
				url_params = build_url({'mode': 'play_media', 'media_type': 'episode', 'tmdb_id': tmdb_id, 'season': season, 'episode': episode})
				display = ep_name
				unaired = False
				if not episode_date or current_date < episode_date:
					if not show_unaired: continue
					if season != 0:
						unaired = True
						display = unaired_label % ep_name
						item['title'] = display
				cm_append((options_str, run_plugin % options_params))
				cm_append((extras_str, run_plugin % extras_params))
				clearprog_params, unwatched_params, watched_params = '', '', ''
				if not unaired:
					if resumetime != '0':
						clearprog_params = build_url({'mode': 'watched_unwatched_erase_bookmark', 'media_type': 'episode', 'tmdb_id': tmdb_id,
													'season': season, 'episode': episode, 'refresh': 'true'})
						cm_append((clearprog_str, run_plugin % clearprog_params))
						set_property('coalition_in_progress', 'true')
					if playcount:
						if hide_watched: continue
						unwatched_params = build_url({'mode': 'mark_as_watched_unwatched_episode', 'action': 'mark_as_unwatched', 'tmdb_id': tmdb_id,
													'tvdb_id': tvdb_id, 'season': season, 'episode': episode,  'title': title, 'year': year})
						cm_append((unwatched_str % watched_title, run_plugin % unwatched_params))
					else:
						watched_params = build_url({'mode': 'mark_as_watched_unwatched_episode', 'action': 'mark_as_watched', 'tmdb_id': tmdb_id,
													'tvdb_id': tvdb_id, 'season': season, 'episode': episode,  'title': title, 'year': year})
						cm_append((watched_str % watched_title, run_plugin % watched_params))
				listitem.setLabel(display)
				listitem.setContentLookup(False)
				listitem.addContextMenuItems(cm)
				listitem.setArt({'poster': show_poster, 'fanart': background, 'thumb': thumb, 'icon':thumb, 'banner': banner, 'clearart': clearart, 'clearlogo': clearlogo,
								'landscape': thumb, 'tvshow.clearart': clearart, 'tvshow.clearlogo': clearlogo, 'tvshow.landscape': thumb, 'tvshow.banner': banner})
				if KODI_VERSION < 20:
					listitem.setCast(cast + item_get('guest_stars', []))
					listitem.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id), 'tvdb': string(tvdb_id)})
					listitem.setInfo('video', remove_meta_keys(item, dict_removals))
					set_property('resumetime', resumetime)
				else:
					videoinfo = listitem.getVideoInfoTag()
					videoinfo.setCast(make_cast_list(cast + item_get('guest_stars', [])))
					videoinfo.setUniqueIDs({'imdb': imdb_id, 'tmdb': string(tmdb_id), 'tvdb': string(tvdb_id)})
					videoinfo.setDirectors(item_get('director').split(', '))
					videoinfo.setDuration(item_get('duration'))
					videoinfo.setEpisode(episode)
					videoinfo.setFirstAired(item_get('premiered'))
					videoinfo.setGenres(genre.split(', '))
					videoinfo.setIMDBNumber(imdb_id)
					videoinfo.setMediaType('episode')
					videoinfo.setMpaa(mpaa)
					videoinfo.setPlaycount(playcount)
					videoinfo.setPlot(item_get('plot'))
					videoinfo.setRating(item_get('rating'))
					videoinfo.setResumePoint(float(resumetime))
					videoinfo.setSeason(season)
					videoinfo.setStudios((studio,))
					videoinfo.setTitle(item_get('title'))
					videoinfo.setTrailer(trailer)
					videoinfo.setTvShowStatus(show_status)
					videoinfo.setTvShowTitle(title)
					videoinfo.setVotes(item_get('votes'))
					videoinfo.setWriters(item_get('writer').split(', '))
					videoinfo.setYear(int(year))
				if is_widget:
					set_property('coalition_widget', 'true')
					set_property('coalition_playcount', string(playcount))
					set_property('coalition_options_menu_params', options_params)
					set_property('coalition_extras_menu_params', extras_params)
					set_property('coalition_unwatched_params', unwatched_params)
					set_property('coalition_watched_params', watched_params)
					set_property('coalition_clearprog_params', clearprog_params)
				else: set_property('coalition_widget', 'false')
				yield (url_params, listitem, False)
			except: pass
	__handle__ = int(sys.argv[1])
	item_list = []
	append = item_list.append
	meta_user_info, watched_indicators, watched_info, show_unaired, thumb_fanart, is_widget, fanart_enabled, hide_watched, current_date, adjust_hours, bookmarks = get_episode_info()
	poster_main, poster_backup, fanart_main, fanart_backup = get_art_provider()
	all_episodes = True if params.get('season') == 'all' else False
	meta = tv_meta_function('tmdb_id', params.get('tmdb_id'), meta_user_info, current_date)
	meta_get = meta.get
	tmdb_id, tvdb_id, imdb_id = meta_get('tmdb_id'), meta_get('tvdb_id'), meta_get('imdb_id')
	title, year, rootname, show_status = meta_get('title'), meta_get('year'), meta_get('rootname'), meta_get('status')
	show_poster = meta_get(poster_main) or meta_get(poster_backup) or poster_empty
	fanart = meta_get(fanart_main) or meta_get(fanart_backup) or fanart_empty
	clearlogo = meta_get('clearlogo') or meta_get('tmdblogo') or ''
	if fanart_enabled: banner, clearart, landscape = meta_get('banner'), meta_get('clearart'), meta_get('landscape')
	else: banner, clearart, landscape = '', '', ''
	cast, mpaa, duration = meta_get('cast', []), meta_get('mpaa'), meta_get('duration')
	trailer, genre, studio = string(meta_get('trailer')), meta_get('genre'), meta_get('studio')
	tvshow_plot = meta_get('plot')
	watched_title = 'Trakt' if watched_indicators == 1 else 'coalition'
	if all_episodes:
		episodes_data = all_episodes_meta_function(meta, meta_user_info, Thread)
		if not show_specials(): episodes_data = [i for i in episodes_data if not i['season'] == 0]
	else: episodes_data = season_meta_function(params['season'], meta, meta_user_info)
	kodi_utils.add_items(__handle__, list(_process()))
	kodi_utils.set_content(__handle__, 'episodes')
	kodi_utils.set_sort_method(__handle__, 'episodes')
	kodi_utils.end_directory(__handle__, False if is_widget else None)
	kodi_utils.set_view_mode('view.episodes', 'episodes')

def get_episode_info():
	meta_user_info = settings.metadata_user_info()
	watched_indicators = settings.watched_indicators()
	watched_info = get_watched_info(watched_indicators)
	show_unaired = settings.show_unaired()
	thumb_fanart = thumb_fanart_info()
	is_widget = kodi_utils.external_browse()
	fanart_enabled = meta_user_info['extra_fanart_enabled']
	hide_watched = is_widget and meta_user_info['widget_hide_watched']
	current_date = get_datetime_function()
	adjust_hours = date_offset_info()
	bookmarks = get_bookmarks(watched_indicators, 'episode')
	return meta_user_info, watched_indicators, watched_info, show_unaired, thumb_fanart, is_widget, fanart_enabled, hide_watched, current_date, adjust_hours, bookmarks

def build_in_progress_episode():
	data = get_in_progress_episodes()
	Episodes('progress', data).build_single_episode()

def build_next_episode():
	nextep_settings = nextep_content_settings()
	include_unwatched = nextep_settings['include_unwatched']
	indicators = settings.watched_indicators()
	watched_info = get_watched_info_tv(indicators)
	data = get_next_episodes(watched_info)
	if indicators == 1:
		list_type = 'next_episode_trakt'
		try:
			hidden_data = trakt_get_hidden_items('progress_watched')
			data = [i for i in data if not i['media_ids']['tmdb'] in hidden_data]
		except: pass
		if include_unwatched:
			try: unwatched = [{'media_ids': i['media_ids'], 'season': 1, 'episode': 0, 'unwatched': True} for i in trakt_fetch_collection_watchlist('watchlist', 'tvshow')]
			except: unwatched = []
			data += unwatched
	else: list_type = 'next_episode_coalition'
	Episodes(list_type, data).build_single_episode()

def build_my_calendar(params):
	recently_aired = params.get('recently_aired', None)
	data = trakt_get_my_calendar(recently_aired, get_datetime())
	if recently_aired: list_type, data = 'trakt_recently_aired', data[:20]
	else: list_type, data = 'trakt_calendar', sorted(data, key=lambda k: k['sort_title'], reverse=False)
	Episodes(list_type, data).build_single_episode()

