# -*- coding: utf-8 -*-
from urllib.parse import parse_qsl
# from modules.kodi_utils import logger

def routing(sys):
	params = dict(parse_qsl(sys.argv[2][1:]))
	mode = params.get('mode', 'navigator.main')
	if 'navigator.' in mode:
		from modules.navigator import Navigator
		exec('Navigator(params).%s()' % mode.split('.')[1])
	elif 'menu_editor.' in mode:
		from modules.menu_editor import MenuEditor
		exec('MenuEditor(params).%s()' % mode.split('.')[1])
	elif 'discover.' in mode:
		if mode == 'discover.remove_from_history':
			from indexers.discover import remove_from_history
			remove_from_history(params)
		elif mode == 'discover.remove_all_history':
			from indexers.discover import remove_all_history
			remove_all_history(params)
		else:
			from indexers.discover import Discover
			exec('Discover(params).%s()' % mode.split('.')[1])
	elif '_play' in mode or 'play_' in mode:
		if mode == 'play_media':
			from modules.sources import Sources
			if 'params' in params:
				import json
				params = json.loads(params['params'])
			Sources().playback_prep(params)
		elif mode == 'play_display_results':
			from modules.sources import Sources
			Sources().display_results()
		elif mode == 'play_file':
			from modules.sources import Sources
			Sources().play_file(params['title'], params['source'])
		elif mode == 'media_play':
			from modules.player import coalitionPlayer
			coalitionPlayer().run(params.get('url', None), params.get('media_type', None))
	elif 'choice' in mode:
		from modules import dialogs
		if mode == 'scraper_color_choice':
			dialogs.scraper_color_choice(params['setting'])
		elif mode == 'scraper_dialog_color_choice':
			dialogs.scraper_dialog_color_choice(params['setting'])
		elif mode == 'scraper_quality_color_choice':
			dialogs.scraper_quality_color_choice(params['setting'])
		elif mode == 'imdb_images_choice':
			dialogs.imdb_images_choice(params['imdb_id'], params['rootname'])
		elif mode == 'set_quality_choice':
			dialogs.set_quality_choice(params['quality_setting'])
		elif mode == 'results_sorting_choice':
			dialogs.results_sorting_choice()
		elif mode == 'results_layout_choice':
			dialogs.results_layout_choice()
		elif mode == 'options_menu_choice':
			dialogs.options_menu(params)
		elif mode == 'meta_language_choice':
			dialogs.meta_language_choice()
		elif mode == 'extras_menu_choice':
			dialogs.extras_menu(params)
		elif mode == 'enable_scrapers_choice':
			dialogs.enable_scrapers_choice()
		elif mode == 'favorites_choice':
			dialogs.favorites_choice(params)
		elif mode == 'trakt_manager_choice':
			dialogs.trakt_manager_choice(params)
		elif mode == 'folder_scraper_manager_choice':
			dialogs.folder_scraper_manager_choice()
		elif mode == 'set_language_filter_choice':
			dialogs.set_language_filter_choice(params['filter_setting'])
		elif mode == 'media_extra_info_choice':
			dialogs.media_extra_info(params['media_type'], params['meta'])
		elif mode == 'extras_lists_choice':
			dialogs.extras_lists_choice()
		elif mode == 'random_choice':
			dialogs.random_choice(params['tmdb_id'], params['poster'])
	elif 'trakt.' in mode or 'trakt_' in mode:
		if 'trakt.list' in mode:
			from modules.utils import manual_function_import
			function = manual_function_import('indexers.trakt', mode.split('.')[-1])
			function(params)
		elif 'trakt.' in mode:
			from modules.utils import manual_function_import
			function = manual_function_import('apis.trakt_api', mode.split('.')[-1])
			function(params)
		else:
			from apis.trakt_api import hide_unhide_trakt_items
			hide_unhide_trakt_items(params['action'], params['media_type'], params['media_id'], params['section'])
	elif 'build' in mode:
		if mode == 'build_movie_list':
			from indexers.movies import Movies
			Movies(params).fetch_list()
		elif mode == 'build_tvshow_list':
			from indexers.tvshows import TVShows
			TVShows(params).fetch_list()
		elif mode == 'build_season_list':
			from indexers.seasons import build_season_list
			build_season_list(params)
		elif mode == 'build_episode_list':
			from indexers.episodes import build_episode_list
			build_episode_list(params)
		elif mode == 'build_next_episode':
			from indexers.episodes import build_next_episode
			build_next_episode()
		elif mode == 'build_in_progress_episode':
			from indexers.episodes import build_in_progress_episode
			build_in_progress_episode()
		elif mode == 'build_my_calendar':
			from indexers.episodes import build_my_calendar
			build_my_calendar(params)
		elif mode == 'build_navigate_to_page':
			from modules.dialogs import build_navigate_to_page
			build_navigate_to_page(params)
		elif mode == 'build_next_episode_manager':
			from modules.episode_tools import build_next_episode_manager
			build_next_episode_manager()
		elif mode == 'imdb_build_user_lists':
			from apis.imdb_api import imdb_build_user_lists
			imdb_build_user_lists(params.get('media_type'))
		elif mode == 'build_popular_people':
			from indexers.people import popular_people
			popular_people()
		elif mode == 'imdb_build_keyword_results':
			from apis.imdb_api import imdb_build_keyword_results
			imdb_build_keyword_results(params['media_type'], params['query'])
	elif 'watched_unwatched' in mode:
		if mode == 'mark_as_watched_unwatched_episode':
			from indexers.watched import mark_as_watched_unwatched_episode
			mark_as_watched_unwatched_episode(params)
		elif mode == 'mark_as_watched_unwatched_season':
			from indexers.watched import mark_as_watched_unwatched_season
			mark_as_watched_unwatched_season(params)
		elif mode == 'mark_as_watched_unwatched_tvshow':
			from indexers.watched import mark_as_watched_unwatched_tvshow
			mark_as_watched_unwatched_tvshow(params)
		elif mode == 'mark_as_watched_unwatched_movie':
			from indexers.watched import mark_as_watched_unwatched_movie
			mark_as_watched_unwatched_movie(params)
		elif mode == 'watched_unwatched_erase_bookmark':
			from indexers.watched import erase_bookmark
			erase_bookmark(params.get('media_type'), params.get('tmdb_id'), params.get('season', ''), params.get('episode', ''), params.get('refresh', 'false'))
	elif 'toggle' in mode:
		if mode == 'toggle_jump_to':
			from modules.kodi_utils import toggle_jump_to
			toggle_jump_to()
		elif mode == 'toggle_provider':
			from modules.utils import toggle_provider
			toggle_provider()
		elif mode == 'toggle_language_invoker':
			from modules.kodi_utils import toggle_language_invoker
			toggle_language_invoker()
	elif 'history' in mode:
		if mode == 'search_history':
			from indexers.history import search_history
			search_history(params)
		elif mode == 'clear_search_history':
			from indexers.history import clear_search_history
			clear_search_history()
		elif mode == 'remove_from_history':
			from indexers.history import remove_from_search_history
			remove_from_search_history(params)
	elif 'furk.' in mode:
		if mode == 'furk.browse_packs':
			from modules.sources import Sources
			Sources().furkPacks(params['file_name'], params['file_id'], params['highlight'])
		elif mode == 'furk.add_to_files':
			from indexers.furk import add_to_files
			add_to_files(params['item_id'])
		elif mode == 'furk.remove_from_files':
			from indexers.furk import remove_from_files
			remove_from_files(params['item_id'])
		elif mode == 'furk.remove_from_downloads':
			from indexers.furk import remove_from_downloads
			remove_from_downloads(params['item_id'])
		elif mode == 'furk.remove_from_files':
			from indexers.furk import add_uncached_file
			add_uncached_file(params['id'])
		elif mode == 'furk.myfiles_protect_unprotect':
			from indexers.furk import myfiles_protect_unprotect
			myfiles_protect_unprotect(params['action'], params['name'], params['item_id'])
		else:
			from modules.utils import manual_function_import
			function = manual_function_import('indexers.furk', mode.split('.')[-1])
			function(params)
	elif 'easynews.' in mode:
		from modules.utils import manual_function_import
		function = manual_function_import('indexers.easynews', mode.split('.')[-1])
		function(params)
	elif 'real_debrid' in mode:
		if mode == 'real_debrid.rd_torrent_cloud':
			from indexers.real_debrid import rd_torrent_cloud
			rd_torrent_cloud()
		if mode == 'real_debrid.rd_downloads':
			from indexers.real_debrid import rd_downloads
			rd_downloads()
		elif mode == 'real_debrid.browse_rd_cloud':
			from indexers.real_debrid import browse_rd_cloud
			browse_rd_cloud(params['id'])
		elif mode == 'real_debrid.resolve_rd':
			from indexers.real_debrid import resolve_rd
			resolve_rd(params)
		elif mode == 'real_debrid.rd_account_info':
			from indexers.real_debrid import rd_account_info
			rd_account_info()
		elif mode == 'real_debrid.delete':
			from indexers.real_debrid import rd_delete
			rd_delete(params.get('id'), params.get('cache_type'))
		elif mode == 'real_debrid.delete_download_link':
			from indexers.real_debrid import delete_download_link
			delete_download_link(params['download_id'])
		elif mode == 'real_debrid.rd_auth':
			from apis.real_debrid_api import RealDebridAPI
			RealDebridAPI().auth()
		elif mode == 'real_debrid.rd_revoke':
			from apis.real_debrid_api import RealDebridAPI
			RealDebridAPI().revoke_auth()
	elif 'premiumize' in mode:
		if mode == 'premiumize.pm_torrent_cloud':
			from indexers.premiumize import pm_torrent_cloud
			pm_torrent_cloud(params.get('id', None), params.get('folder_name', None))
		elif mode == 'premiumize.pm_transfers':
			from indexers.premiumize import pm_transfers
			pm_transfers()
		elif mode == 'premiumize.pm_account_info':
			from indexers.premiumize import pm_account_info
			pm_account_info()
		elif mode == 'premiumize.rename':
			from indexers.premiumize import pm_rename
			pm_rename(params.get('file_type'), params.get('id'), params.get('name'))
		elif mode == 'premiumize.delete':
			from indexers.premiumize import pm_delete
			pm_delete(params.get('file_type'), params.get('id'))
		elif mode == 'premiumize.pm_auth':
			from apis.premiumize_api import PremiumizeAPI
			PremiumizeAPI().auth()
		elif mode == 'premiumize.pm_revoke':
			from apis.premiumize_api import PremiumizeAPI
			PremiumizeAPI().revoke_auth()
	elif 'alldebrid' in mode:
		if mode == 'alldebrid.ad_torrent_cloud':
			from indexers.alldebrid import ad_torrent_cloud
			ad_torrent_cloud(params.get('id', None))
		elif mode == 'alldebrid.browse_ad_cloud':
			from indexers.alldebrid import browse_ad_cloud
			browse_ad_cloud(params['folder'])
		elif mode == 'alldebrid.resolve_ad':
			from indexers.alldebrid import resolve_ad
			resolve_ad(params)
		elif mode == 'alldebrid.ad_account_info':
			from indexers.alldebrid import ad_account_info
			ad_account_info()
		elif mode == 'alldebrid.ad_auth':
			from apis.alldebrid_api import AllDebridAPI
			AllDebridAPI().auth()
		elif mode == 'alldebrid.ad_revoke':
			from apis.alldebrid_api import AllDebridAPI
			AllDebridAPI().revoke_auth()
	elif '_settings' in mode:
		if mode == 'open_settings':
			from modules.kodi_utils import open_settings
			open_settings(params.get('query'))
		elif mode == 'clean_settings':
			from modules.kodi_utils import clean_settings
			clean_settings()
		elif mode == 'erase_all_settings':
			from modules.nav_utils import erase_all_settings
			erase_all_settings()
		elif mode == 'external_settings':
			from modules.kodi_utils import open_settings
			open_settings(params.get('query', '0.0'), params.get('ext_addon'))
		elif mode == 'clean_settings_window_properties':
			from modules.kodi_utils import clean_settings_window_properties
			clean_settings_window_properties()
	elif '_cache' in mode:
		import caches
		caches.clear_cache(params.get('cache'))
	elif '_image' in mode:
		from indexers.images import Images
		Images().run(params)
	elif '_text' in mode:
		if mode == 'show_text':
			from modules.kodi_utils import show_text
			show_text(params.get('heading'), params.get('text', None), params.get('file', None),
								params.get('font_size', 'small'), params.get('kodi_log', 'false') == 'true')
		elif mode == 'show_text_media':
			from modules.kodi_utils import show_text_media
			show_text(params.get('heading'), params.get('text', None), params.get('file', None), params.get('meta'), {})
	elif '_view' in mode:
		from modules import kodi_utils
		if mode == 'choose_view':
			kodi_utils.choose_view(params['view_type'], params.get('content', ''))
		elif mode == 'set_view':
			kodi_utils.set_view(params['view_type'])
	##EXTRA modes##
	elif mode == 'get_search_term':
		from indexers.history import get_search_term
		get_search_term(params)
	elif 'person_data_dialog' in mode:
		from indexers.people import person_data_dialog
		person_data_dialog(params)
	elif mode == 'downloader':
		from modules.downloader import runner
		runner(params)
	elif mode == 'clean_databases':
		from caches import clean_databases
		clean_databases()
	elif mode == 'manual_add_magnet_to_cloud':
		from modules.debrid import manual_add_magnet_to_cloud
		manual_add_magnet_to_cloud(params)
	elif mode == 'debrid.browse_packs':
		from modules.sources import Sources
		Sources().debridPacks(params['provider'], params['name'], params['magnet_url'], params['info_hash'], params['highlight'])
	elif mode == 'upload_logfile':
		from modules.kodi_utils import upload_logfile
		upload_logfile()
	##gears modes###
	elif mode == 'undesirablesInput':
		from caches.undesirables_cache import undesirablesInput
		undesirablesInput()
	elif mode == 'undesirablesUserRemove':
		from caches.undesirables_cache import undesirablesUserRemove
		undesirablesUserRemove()

