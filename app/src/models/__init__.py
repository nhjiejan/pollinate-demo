# flake8: noqa
# TODO: check if there is a better way
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

from .abc import BaseModel
from .pol import Pol

__all__ = ['BaseModel', 'Pol']
