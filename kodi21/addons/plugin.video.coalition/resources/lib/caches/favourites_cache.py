# -*- coding: utf-8 -*-
import json
from modules import settings
from modules.utils import sort_for_article, paginate_list
from modules.kodi_utils import notification, execute_builtin, database, favorites_db, local_string as ls
# from modules.kodi_utils import logger

timeout = 40
INSERT_FAV = 'INSERT INTO favourites VALUES (?, ?, ?)'
DELETE_FAV = 'DELETE FROM favourites where db_type=? and tmdb_id=?'
SELECT_FAV = 'SELECT tmdb_id, title FROM favourites WHERE db_type=?'
CLEAR_FAV = 'DELETE FROM favourites WHERE db_type=?'

class Favourites:
	def __init__(self):
		self._connect_database()
		self.set_PRAGMAS()

	def add_to_favourites(self, media_type, tmdb_id, title):
		try:
			self.dbcur.execute(INSERT_FAV, (media_type, str(tmdb_id), title))
			notification(32576)
		except: notification(32574)

	def remove_from_favourites(self, media_type, tmdb_id, title):
		try:
			self.dbcur.execute(DELETE_FAV, (media_type, str(tmdb_id)))
			execute_builtin('Container.Refresh')
			notification(32576)
		except: notification(32574)

	def get_favourites(self, media_type):
		self.dbcur.execute(SELECT_FAV, (media_type,))
		result = self.dbcur.fetchall()
		result = [{'tmdb_id': str(i[0]), 'title': str(i[1])} for i in result]
		return result

	def clear_favourites(self, media_type):
		try:
			self.dbcur.execute(CLEAR_FAV, (media_type,))
			self.dbcur.execute('VACUUM')
			notification(32576)
		except: notification(32574)

	def _connect_database(self):
		self.dbcon = database.connect(favorites_db, timeout=timeout, isolation_level=None)

	def set_PRAGMAS(self):
		self.dbcur = self.dbcon.cursor()
		self.dbcur.execute('''PRAGMA synchronous = OFF''')
		self.dbcur.execute('''PRAGMA journal_mode = OFF''')

favourites_cache = Favourites()

def retrieve_favourites(media_type, page_no, letter):
	paginate = settings.paginate()
	limit = settings.page_limit()
	data = favourites_cache.get_favourites(media_type)
	data = sort_for_article(data, 'title', settings.ignore_articles())
	original_list = [{'media_id': i['tmdb_id'], 'title': i['title']} for i in data]
	if paginate: final_list, total_pages = paginate_list(original_list, page_no, letter, limit)
	else: final_list, total_pages = original_list, 1
	return final_list, total_pages

