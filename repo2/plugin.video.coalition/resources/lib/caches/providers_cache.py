# -*- coding: utf-8 -*-
import time
from datetime import datetime, timedelta
from modules.kodi_utils import confirm_dialog, path_exists, database, external_db
# from modules.kodi_utils import logger

timeout = 240
SELECT_RESULTS = 'SELECT results, expires FROM results_data WHERE provider = ? AND db_type = ? AND tmdb_id = ? AND title = ? AND year = ? AND season = ? AND episode = ?'
DELETE_RESULTS = 'DELETE FROM results_data WHERE provider = ? AND db_type = ? AND tmdb_id = ? AND title = ? AND year = ? AND season = ? AND episode = ?'
INSERT_RESULTS = 'INSERT OR REPLACE INTO results_data VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
SINGLE_DELETE = 'DELETE FROM results_data WHERE db_type=? AND tmdb_id=?'
FULL_DELETE = 'DELETE FROM results_data'

class ExternalProvidersCache:
	def __init__(self):
		self._connect_database()
		self._set_PRAGMAS()

	def get(self, source, media_type, tmdb_id, title, year, season, episode):
		result = None
		try:
			self.dbcur.execute(SELECT_RESULTS, (source, media_type, tmdb_id, title, year, season, episode))
			cache_data = self.dbcur.fetchone()
			if cache_data:
				if cache_data[1] > self._get_timestamp(datetime.now()): result = eval(cache_data[0])
				else: self.delete(source, media_type, title, year, tmdb_id, season, episode, dbcon)
		except: pass
		return result

	def set(self, source, media_type, tmdb_id, title, year, season, episode, results, expire_time):
		try:
			expiration = timedelta(hours=expire_time)
			expires = self._get_timestamp(datetime.now() + expiration)
			self.dbcur.execute(INSERT_RESULTS, (source, media_type, tmdb_id, title, year, season, episode, repr(results), int(expires)))
		except: pass

	def delete(self, source, media_type, tmdb_id, title, season, episode):
		try: self.dbcur.execute(DELETE_RESULTS, (source, media_type, tmdb_id, title, season, episode))
		except: return

	def delete_cache(self, silent=False):
		try:
			if not path_exists(external_db): return 'failure'
			if not silent and not confirm_dialog(): return 'cancelled'
			self.dbcur.execute(FULL_DELETE, ())
			self.dbcur.execute('VACUUM')
			return 'success'
		except: return 'failure'

	def delete_cache_single(self, media_type, tmdb_id):
		try:
			if not path_exists(external_db): return False
			self.dbcur.execute(SINGLE_DELETE, (media_type, tmdb_id))
			self.dbcur.execute('VACUUM')
			return True
		except: return False

	def _connect_database(self):
		self.dbcon = database.connect(external_db, timeout=timeout, isolation_level=None)

	def _set_PRAGMAS(self):
		self.dbcur = self.dbcon.cursor()
		self.dbcur.execute('''PRAGMA synchronous = OFF''')
		self.dbcur.execute('''PRAGMA journal_mode = OFF''')

	def _get_timestamp(self, date_time):
		return int(time.mktime(date_time.timetuple()))

