from . import db
from .abc import BaseModel


class Pol(db.Model, BaseModel):
    id = db.Column(db.Integer , primary_key=True , autoincrement=True)
    hostname = db.Column(db.String, unique=False, nullable=False)
    datetimestamp = db.Column(db.String, nullable=True)

    def __init__(self, hostname: str, datetimestamp: str = ''):
        self.hostname = hostname
        self.datetimestamp = datetimestamp
