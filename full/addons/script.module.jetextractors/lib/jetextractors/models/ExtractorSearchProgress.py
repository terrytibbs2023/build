from .Extractor import Extractor

class ExtractorSearchProgress:
    done: int
    total: int
    links: int

    def __init__(self,) -> None:
        self.done = 0
        self.total = -1
        self.links = 0
