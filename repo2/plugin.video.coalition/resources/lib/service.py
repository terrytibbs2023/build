# -*- coding: utf-8 -*-
import time
import datetime
import xml.etree.ElementTree as ET
from threading import Thread
from caches import check_databases, clean_databases
from caches.trakt_cache import clear_trakt_list_contents_data
from apis.trakt_api import trakt_sync_activities
from modules import kodi_utils, settings
from apis.alldebrid_api import AllDebridAPI
from apis.premiumize_api import PremiumizeAPI
from apis.real_debrid_api import RealDebridAPI
#from gears.undesirables import Undesirables, add_new_default_keywords

logger = kodi_utils.logger
ls, monitor, path_exists, translate_path, is_playing = kodi_utils.local_string, kodi_utils.monitor, kodi_utils.path_exists, kodi_utils.translate_path, kodi_utils.player.isPlaying
get_property, set_property, clear_property, get_visibility = kodi_utils.get_property, kodi_utils.set_property, kodi_utils.clear_property, kodi_utils.get_visibility
get_setting, set_setting, make_settings_dict = kodi_utils.get_setting, kodi_utils.set_setting, kodi_utils.make_settings_dict

class InitializeDatabases:
	def run(self):
		logger('coalition', 'InitializeDatabases Service Starting')
		check_databases()
		return logger('coalition', 'InitializeDatabases Service Finished')

class CheckSettingsFile:
	def run(self):
		logger('coalition', 'CheckSettingsFile Service Starting')
		clear_property('coalition_settings')
		profile_dir = translate_path('special://profile/addon_data/plugin.video.coalition/')
		if not path_exists(profile_dir): kodi_utils.make_directorys(profile_dir)
		settings_xml = translate_path('special://profile/addon_data/plugin.video.coalition/settings.xml')
		if not path_exists(settings_xml):
			__addon__ = kodi_utils.addon()
#			addon_version = __addon__.getAddonInfo('version')
#			__addon__.setSetting('version_number', addon_version)
			__addon__.setSetting('kodi_menu_cache', 'true')
			monitor.waitForAbort(0.5)
		make_settings_dict()
		set_property('coalition_kodi_menu_cache', get_setting('kodi_menu_cache'))
		return logger('coalition', 'CheckSettingsFile Service Finished')

class ClearSubs:
	def run(self):
		logger('coalition', 'Clear Subtitles Service Starting')
		sub_formats = ('.srt', '.ssa', '.smi', '.sub', '.idx')
		subtitle_path = 'special://temp/%s'
		files = kodi_utils.list_dirs(translate_path('special://temp/'))[1]
		for i in files:
			if i.startswith('coalitionSubs_') or i.endswith(sub_formats): kodi_utils.delete_file(translate_path(subtitle_path % i))
		return logger('coalition', 'Clear Subtitles Service Finished')

class ReuseLanguageInvokerCheck:
	def run(self):
		logger('coalition', 'ReuseLanguageInvokerCheck Service Starting')
		addon_xml = translate_path('special://home/addons/plugin.video.coalition/addon.xml')
		tree = ET.parse(addon_xml)
		root = tree.getroot()
		current_addon_setting = get_setting('reuse_language_invoker', 'true')
		refresh, text = True, '%s\n%s' % (ls(33021), ls(33020))
		for item in root.iter('reuselanguageinvoker'):
			if item.text == current_addon_setting: refresh = False; break
			item.text = current_addon_setting
			tree.write(addon_xml)
			break
		if refresh and kodi_utils.confirm_dialog(text=text): kodi_utils.execute_builtin('LoadProfile(%s)' % kodi_utils.get_infolabel('system.profilename'))
		return logger('coalition', 'ReuseLanguageInvokerCheck Service Finished')

class ViewsSetWindowProperties:
	def run(self):
		logger('coalition', 'ViewsSetWindowProperties Service Starting')
		kodi_utils.set_view_properties()
		return logger('coalition', 'ViewsSetWindowProperties Service Finished')

class AutoRun:
	def run(self):
		logger('coalition', 'AutoRun Service Starting')
		if settings.auto_start_coalition(): kodi_utils.execute_builtin('RunAddon(plugin.video.coalition)')
		return logger('coalition', 'AutoRun Service Finished')

class DatabaseMaintenance:
	def run(self):
		time = datetime.datetime.now()
		current_time = self._get_timestamp(time)
		due_clean = int(get_setting('database.maintenance.due', '0'))
		if current_time >= due_clean:
			logger('coalition', 'Database Maintenance Service Starting')
			monitor.waitForAbort(10)
			clean_databases(current_time, database_check=False, silent=True)
			next_clean = str(int(self._get_timestamp(time + datetime.timedelta(days=3))))
			set_setting('database.maintenance.due', next_clean)
			return logger('coalition', 'Database Maintenance Service Finished')

	def _get_timestamp(self, date_time):
		return int(time.mktime(date_time.timetuple()))

class TraktMonitor:
	def run(self):
		logger('coalition', 'TraktMonitor Service Starting')
		trakt_service_string = 'TraktMonitor Service Update %s - %s'
		update_string = 'Next Update in %s minutes...'
		if not kodi_utils.get_property('coalition_traktmonitor_first_run') == 'true':
			clear_trakt_list_contents_data('user_lists')
			kodi_utils.set_property('coalition_traktmonitor_first_run', 'true')
		while not monitor.abortRequested():
			while is_playing() or get_visibility('Container().isUpdating') or get_property('coalition_pause_services') == 'true': monitor.waitForAbort(10)
			if not kodi_utils.get_property('coalition_traktmonitor_first_run') == 'true': monitor.waitForAbort(5)
			value, interval = settings.trakt_sync_interval()
			next_update_string = update_string % value
			status = trakt_sync_activities()
			if status == 'success':
				logger('coalition', trakt_service_string % ('coalition TraktMonitor - Success', 'Trakt Update Performed'))
				if settings.trakt_sync_refresh_widgets():
					kodi_utils.widget_refresh()
					logger('coalition', trakt_service_string % ('coalition TraktMonitor - Widgets Refresh', 'Setting Activated. Widget Refresh Performed'))
				else: logger('coalition', trakt_service_string % ('coalition TraktMonitor - Widgets Refresh', 'Setting Disabled. Skipping Widget Refresh'))
			elif status == 'no account':
				logger('coalition', trakt_service_string % ('coalition TraktMonitor - Aborted. No Trakt Account Active', next_update_string))
			elif status == 'failed':
				logger('coalition', trakt_service_string % ('coalition TraktMonitor - Failed. Error from Trakt', next_update_string))
			else:# 'not needed'
				logger('coalition', trakt_service_string % ('coalition TraktMonitor - Success. No Changes Needed', next_update_string))
			monitor.waitForAbort(interval)
		return logger('coalition', 'TraktMonitor Service Finished')

class PremAccntNotification:
	def run(self):
		logger('coalition', 'Debrid Account Expiry Notification Service Starting')
		self.duration = 7
		if get_setting('ad.account_id') != '':
			account_info = AllDebridAPI().account_info()['user']
			if account_info:
				if not account_info['isSubscribed']:
					expires = datetime.datetime.fromtimestamp(account_info['premiumUntil'])
					days_remaining = (expires - datetime.datetime.today()).days
					if days_remaining <= self.duration:
						kodi_utils.notification('AllDebrid expires in %s days' % days_remaining)
		if get_setting('pm.account_id') != '':
			account_info = PremiumizeAPI().account_info()
			if account_info:
				expires = datetime.datetime.fromtimestamp(account_info['premium_until'])
				days_remaining = (expires - datetime.datetime.today()).days
				if days_remaining <= self.duration:
					kodi_utils.notification('Premiumize.me expires in %s days' % days_remaining)
		if get_setting('rd.username') != '':
			account_info = RealDebridAPI().account_info()
			if account_info:
				FormatDateTime = "%Y-%m-%dT%H:%M:%S.%fZ"
				try: expires = datetime.datetime.strptime(account_info['expiration'], FormatDateTime)
				except: expires = datetime.datetime(*(time.strptime(account_info['expiration'], FormatDateTime)[0:6]))
				days_remaining = (expires - datetime.datetime.today()).days
				if days_remaining <= self.duration:
					kodi_utils.notification('Real-Debrid expires in %s days' % days_remaining)
		return logger('coalition', 'Debrid Account Expiry Notification Service Finished')

class CheckUndesirablesDatabase:
	def run(self):
		from gears.undesirables import Undesirables, add_new_default_keywords
		logger('coalition', 'CheckUndesirablesDatabase Service Starting')
		old_database = Undesirables().check_database()
		if old_database: add_new_default_keywords()
		return logger('coalition', 'CheckUndesirablesDatabase Service Finished')

class coalitionMonitor(kodi_utils.xbmc_monitor):
	def __init__ (self):
		kodi_utils.xbmc_monitor.__init__(self)
		self.startUpServices()

	def startUpServices(self):
		functions = (DatabaseMaintenance().run, TraktMonitor().run, PremAccntNotification().run)
		threads = [Thread(target=item) for item in functions]
		while not self.abortRequested():
			try: InitializeDatabases().run()
			except: pass
			try: CheckSettingsFile().run()
			except: pass
			try: CheckUndesirablesDatabase().run()
			except: pass
			[i.start() for i in threads]
			try: ClearSubs().run()
			except: pass
			try: ViewsSetWindowProperties().run()
			except: pass
			try: AutoRun().run()
			except: pass
			try: ReuseLanguageInvokerCheck().run()
			except: pass
			break

	def onScreensaverActivated(self):
		set_property('coalition_pause_services', 'true')

	def onScreensaverDeactivated(self):
		clear_property('coalition_pause_services')

	def onSettingsChanged(self):
		clear_property('coalition_settings')
		kodi_utils.sleep(50)
		make_settings_dict()
		set_property('coalition_kodi_menu_cache', get_setting('kodi_menu_cache'))

	def onNotification(self, sender, method, data):
		if method == 'System.OnSleep': set_property('coalition_pause_services', 'true')
		elif method == 'System.OnWake': clear_property('coalition_pause_services')


logger('coalition', 'Main Monitor Service Starting')
logger('coalition', 'Settings Monitor Service Starting')

coalitionMonitor().waitForAbort()

logger('coalition', 'Settings Monitor Service Finished')
logger('coalition', 'Main Monitor Service Finished')

