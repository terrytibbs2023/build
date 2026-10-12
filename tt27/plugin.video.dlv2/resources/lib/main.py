import json
from urllib.parse import unquote_plus
from  .DI import DI
from  .plugin import run_hook, register_routes

plugin = DI.plugin

@plugin.route("/")
def root() -> None:
    _get_list('ddlv')


@plugin.route("/get_list/<path:url>")
def get_list(url: str) -> None:
    _get_list(url)


def _get_list(url):
    response = run_hook("get_list", url)
    if response:
        jen_list = run_hook("parse_list", url, response)
        jen_list = [run_hook("process_item", item) for item in jen_list]
        jen_list = [
            run_hook("get_metadata", item, return_item_on_failure=True) for item in jen_list
        ]
        run_hook("display_list", jen_list)
    else:
        run_hook("display_list", [])


@plugin.route("/play_video/<path:video>")
def play_video(video: str):
    _play_video(video)


def _play_video(video):
    video = json.loads(unquote_plus(video))
    if video:
        run_hook("play_video", video)


def main():
    register_routes(plugin)
    plugin.run()
    return 0


if __name__ == "__main__":
    main()
