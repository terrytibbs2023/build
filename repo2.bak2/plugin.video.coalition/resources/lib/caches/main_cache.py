# -*- coding: utf-8 -*-
import time
from datetime import datetime, timedelta
from modules.kodi_utils import get_property, set_property, clear_property, database, maincache_db
# from modules.kodi_utils import logger

timeout = 240
table = 'maincache'
BASE_GET = 'SELECT expires, data FROM %s WHERE id = ?'
BASE_SET = 'INSERT OR REPLACE INTO %s(id, data, expires) VALUES (?, ?, ?)'
BASE_DELETE = 'DELETE FROM %s WHERE id = ?'
LIKE_SELECT = 'SELECT id from maincache where id LIKE %s'
LIKE_DELETE = 'DELETE FROM maincache WHERE id LIKE %s'
DELETE = 'DELETE FROM maincache WHERE id=?'
ALL_LIST_ADD = ' OR id LIKE '

class MainCache:
	def get(self, string):
		result = None
		try:
			current_time = self._get_timestamp(datetime.now())
			result = self.get_memory_cache(string, current_time)
			if result is None:
				dbcon = self.connect_database()
				dbcur = self.set_PRAGMAS(dbcon)
				dbcur.execute(BASE_GET % table, (string,))
				cache_data = dbcur.fetchone()
				if cache_data:
					if cache_data[0] > current_time:
						result = eval(cache_data[1])
						self.set_memory_cache(result, string, cache_data[1])
					else:
						self.delete(string, dbcon)
		except: pass
		return result

	def set(self, string, data, expiration=timedelta(days=30)):
		try:
			expires = self._get_timestamp(datetime.now() + expiration)
			dbcon = self.connect_database()
			dbcur = self.set_PRAGMAS(dbcon)
			dbcur.execute(BASE_SET % table, (string, repr(data), int(expires)))
			self.set_memory_cache(data, string, int(expires))
		except: return None

	def get_memory_cache(self, string, current_time):
		result = None
		try:
			try: cachedata = get_property(string.encode('utf-8'))
			except: cachedata = get_property(string)
			if cachedata:
				cachedata = eval(cachedata)
				if cachedata[0] > current_time: result = cachedata[1]
		except: pass
		return result

	def set_memory_cache(self, data, string, expires):
		try:
			cachedata = (expires, data)
			try: cachedata_repr = repr(cachedata).encode('utf-8')
			except: cachedata_repr = repr(cachedata)
			set_property(string, cachedata_repr)
		except: pass

	def delete(self, string, dbcon=None):
		try:
			if not dbcon: self.connect_database()
			dbcur = dbcon.cursor()
			dbcur.execute(BASE_DELETE % table, (string,))
			self.delete_memory_cache(string)
		except: pass

	def delete_memory_cache(self, string):
		clear_property(string)

	def delete_all_lists(self):
		from modules.meta_lists import media_lists
		media_list = media_lists
		dbcon = self.connect_database()
		dbcur = self.set_PRAGMAS(dbcon)
		len_media_list = len(media_list)
		for count, item in enumerate(media_list, 1):
			if count == 1: command = LIKE_SELECT % item
			else: command += '%s%s' % (ALL_LIST_ADD, item)
		dbcur.execute(command)
		results = dbcur.fetchall()
		try:
			for item in results:
				try:
					dbcur.execute(DELETE, (str(item[0]),))
					self.delete_memory_cache(str(item[0]))
				except: pass
			dbcon.execute('VACUUM')
		except: pass

	def delete_all_folderscrapers(self):
		dbcon = self.connect_database()
		dbcur = self.set_PRAGMAS(dbcon)
		dbcur.execute(LIKE_SELECT % "'coalition_FOLDERSCRAPER_%'")
		remove_list = [str(i[0]) for i in dbcur.fetchall()]
		if not remove_list: return 'success'
		try:
			dbcur.execute(LIKE_DELETE % "'coalition_FOLDERSCRAPER_%'")
			dbcon.execute('VACUUM')
			for item in remove_list: self.delete_memory_cache(str(item))
		except: pass

	def connect_database(self):
		return database.connect(maincache_db, timeout=timeout, isolation_level=None)

	def set_PRAGMAS(self, dbcon):
		dbcur = dbcon.cursor()
		dbcur.execute('''PRAGMA synchronous = OFF''')
		dbcur.execute('''PRAGMA journal_mode = OFF''')
		return dbcur

	def _get_timestamp(self, date_time):
		return int(time.mktime(date_time.timetuple()))

main_cache = MainCache()

def cache_object(function, string, url, json=True, expiration=24):
	cache = main_cache.get(string)
	if cache: return cache
	if isinstance(url, list): args = tuple(url)
	else: args = (url,)
	if json: result = function(*args).json()
	else: result = function(*args)
	main_cache.set(string, result, expiration=timedelta(hours=expiration))
	return result

