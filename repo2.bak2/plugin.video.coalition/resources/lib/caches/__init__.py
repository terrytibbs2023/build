# -*- coding: utf-8 -*-
from threading import Thread
from modules import kodi_utils
from modules.utils import make_thread_list
# logger = kodi_utils.logger

ls = kodi_utils.local_string
database = kodi_utils.database
delete_file = kodi_utils.delete_file
navigator_db = kodi_utils.navigator_db
watched_db = kodi_utils.watched_db
favorites_db = kodi_utils.favorites_db
views_db = kodi_utils.views_db
trakt_db = kodi_utils.trakt_db
maincache_db = kodi_utils.maincache_db
metacache_db = kodi_utils.metacache_db
debridcache_db = kodi_utils.debridcache_db
external_db = kodi_utils.external_db
databases_path = kodi_utils.databases_path
current_dbs = kodi_utils.current_dbs

def check_databases():
	if not kodi_utils.path_exists((databases_path)): kodi_utils.make_directory(databases_path)
	remove_old_databases()
	#Navigator
	dbcon = database.connect(navigator_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS navigator
				(list_name text, list_type text, list_contents text, unique(list_name, list_type))""")
	dbcon.close()
	# Watched Status
	dbcon = database.connect(watched_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS watched_status
					(db_type text, media_id text, season integer, episode integer, last_played text, title text, unique(db_type, media_id, season, episode))""")
	dbcon.execute("""CREATE TABLE IF NOT EXISTS progress
					(db_type text, media_id text, season integer, episode integer, resume_point text, curr_time text,
					last_played text, resume_id integer, title text, unique(db_type, media_id, season, episode))""")
	dbcon.close()
	# Favourites
	dbcon = database.connect(favorites_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS favourites (db_type text, tmdb_id text, title text, unique (db_type, tmdb_id))""")
	dbcon.close()
	# Views
	dbcon = database.connect(views_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS views (view_type text, view_id text, unique (view_type))""")
	dbcon.close()
	# Trakt
	dbcon = database.connect(trakt_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS trakt_data (id text unique, data text)""")
	dbcon.execute("""CREATE TABLE IF NOT EXISTS watched_status
					(db_type text, media_id text, season integer, episode integer, last_played text, title text, unique(db_type, media_id, season, episode))""")
	dbcon.execute("""CREATE TABLE IF NOT EXISTS progress
					(db_type text, media_id text, season integer, episode integer, resume_point text, curr_time text,
					last_played text, resume_id integer, title text, unique(db_type, media_id, season, episode))""")
	dbcon.close()
	# Main Cache
	dbcon = database.connect(maincache_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS maincache (id text unique, data text, expires integer)""")
	dbcon.close()
	# Meta Cache
	dbcon = database.connect(metacache_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS metadata
					  (db_type text not null, tmdb_id text not null, imdb_id text, tvdb_id text, meta text, expires integer, unique (db_type, tmdb_id))""")
	dbcon.execute("""CREATE TABLE IF NOT EXISTS season_metadata (tmdb_id text not null unique, meta text, expires integer)""")
	dbcon.execute("""CREATE TABLE IF NOT EXISTS function_cache (string_id text not null, data text, expires integer)""")
	dbcon.close()
	# Debrid Cache
	dbcon = database.connect(debridcache_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS debrid_data (hash text not null, debrid text not null, cached text, expires integer, unique (hash, debrid))""")
	dbcon.close()
	# External Providers Cache
	dbcon = database.connect(external_db)
	dbcon.execute("""CREATE TABLE IF NOT EXISTS results_data
					(provider text, db_type text, tmdb_id text, title text, year integer, season text, episode text, results text,
					expires integer, unique (provider, db_type, tmdb_id, title, year, season, episode))""")
	dbcon.close()

def remove_old_databases():
	files = kodi_utils.list_dirs(databases_path)[1]
	for item in files:
		if not item in current_dbs:
			try: delete_file(databases_path + item)
			except: pass

def clean_databases(current_time=None, database_check=True, silent=False):
	def _process(args):
		try:
			dbcon = database.connect(args[0], timeout=60.0)
			dbcur = dbcon.cursor()
			dbcur.execute('''PRAGMA synchronous = OFF''')
			dbcur.execute('''PRAGMA journal_mode = OFF''')
			dbcur.execute(args[1], (current_time,))
			dbcon.commit()
			dbcur.execute('VACUUM')
		except: pass
	if database_check: check_databases()
	if not current_time: current_time = get_current_time()
	command_base = 'DELETE from %s WHERE CAST(%s AS INT) <= ?'
	functions_list = ((external_db, command_base % ('results_data', 'expires')),
					(maincache_db, command_base % ('maincache', 'expires')),
					(metacache_db, command_base % ('metadata', 'expires')),
					(metacache_db, command_base % ('function_cache', 'expires')),
					(metacache_db, command_base % ('season_metadata', 'expires')),
					(debridcache_db, command_base % ('debrid_data', 'expires')))
	threads = list(make_thread_list(_process, functions_list, Thread))
	[i.join() for i in threads]
	limit_metacache_database()
	if not silent: kodi_utils.notification(32576, time=2000)

def limit_metacache_database(max_size=50):
	with kodi_utils.open_file(metacache_db) as f: s = f.size()
	size = round(float(s)/1048576, 1)
	if size < max_size: return
	dbcon = database.connect(metacache_db, timeout=60.0)
	dbcur = dbcon.cursor()
	dbcur.execute('''PRAGMA synchronous = OFF''')
	dbcur.execute('''PRAGMA journal_mode = OFF''')
	dbcur.execute('DELETE FROM metadata WHERE ROWID IN (SELECT ROWID FROM metadata ORDER BY ROWID DESC LIMIT -1 OFFSET 4000)')
	dbcur.execute('DELETE FROM function_cache WHERE ROWID IN (SELECT ROWID FROM function_cache ORDER BY ROWID DESC LIMIT -1 OFFSET 100)')
	dbcur.execute('DELETE FROM season_metadata WHERE ROWID IN (SELECT ROWID FROM season_metadata ORDER BY ROWID DESC LIMIT -1 OFFSET 100)')
	dbcon.commit()
	dbcon.execute('VACUUM')

def get_current_time():
	import time, datetime
	return int(time.mktime(datetime.datetime.now().timetuple()))

def refresh_cached_meta(meta):
	from caches.meta_cache import metacache
	try:
		media_type, tmdb_id = meta['mediatype'], meta['tmdb_id']
		metacache.delete(media_type, 'tmdb_id', tmdb_id, meta)
		if media_type == 'tvshow': metacache.delete_all_seasons_memory_cache(tmdb_id)
		kodi_utils.notification(32576, time=2000)
		kodi_utils.execute_builtin('Container.Refresh')
	except: kodi_utils.notification(32574)

def clear_cache(cache_type, silent=False):
	def _confirm():
		return silent or kodi_utils.confirm_dialog()
	success = True
	if cache_type == 'all':
		if not _confirm(): return
		clear_all_cache()
	elif cache_type == 'meta':
		if not _confirm(): return
		from caches.meta_cache import metacache
		metacache.delete_all()
	elif cache_type == 'internal_scrapers':
		if not _confirm(): return
		from apis import furk_api, easynews_api
		furk_api.clear_media_results_database()
		easynews_api.clear_media_results_database()
		for item in ('pm_cloud', 'rd_cloud', 'ad_cloud', 'folders'): clear_cache(item, silent=True)
	elif cache_type == 'external_scrapers':
		from caches.providers_cache import ExternalProvidersCache
		from caches.debrid_cache import DebridCache
		data = ExternalProvidersCache().delete_cache(silent=silent)
		debrid_cache = DebridCache().clear_database()
		success = (data, debrid_cache) == ('success', 'success')
	elif cache_type == 'trakt':
		from caches.trakt_cache import clear_all_trakt_cache_data
		success = clear_all_trakt_cache_data(silent=silent)
	elif cache_type == 'imdb':
		if not _confirm(): return
		from apis.imdb_api import clear_imdb_cache
		success = clear_imdb_cache()
	elif cache_type == 'pm_cloud':
		if not _confirm(): return
		from apis.premiumize_api import PremiumizeAPI
		success = PremiumizeAPI().clear_cache()
	elif cache_type == 'rd_cloud':
		if not _confirm(): return
		from apis.real_debrid_api import RealDebridAPI
		success = RealDebridAPI().clear_cache()
	elif cache_type == 'ad_cloud':
		if not _confirm(): return
		from apis.alldebrid_api import AllDebridAPI
		success = AllDebridAPI().clear_cache()
	elif cache_type == 'folders':
		from caches.main_cache import main_cache
		main_cache.delete_all_folderscrapers()
	else: # 'list'
		if not _confirm(): return
		from caches.main_cache import main_cache
		main_cache.delete_all_lists()
	if not silent and success: kodi_utils.notification(32576, time=2000)

def clear_all_cache():
	line = '[CR]%s: [B]%s[/B]'
	kodi_utils.progressDialog.create('coalition', '')
	caches = (('meta', '%s %s' % (ls(32527), ls(32524))), ('list', '%s %s' % (ls(32815), ls(32524))), ('trakt', ls(32087)), ('imdb', '%s %s' % (ls(32064), ls(32524))),
			('internal_scrapers', '%s %s' % (ls(32096), ls(32524))), ('external_scrapers', '%s %s' % (ls(32118), ls(32524))),
			('rd_cloud', '%s %s' % (ls(32054), ls(32524))), ('pm_cloud', '%s %s' % (ls(32061), ls(32524))), ('ad_cloud', '%s %s' % (ls(32063), ls(32524))))
	for count, cache_type in enumerate(caches, 1):
		try:
			kodi_utils.progressDialog.update(int(float(count) / float(len(caches)) * 100), line % (ls(32816), cache_type[1]))
			clear_cache(cache_type[0], silent=True)
			kodi_utils.sleep(200)
		except: pass
	kodi_utils.progressDialog.close()
	kodi_utils.sleep(100)
	kodi_utils.notification(32576, time=2000)

