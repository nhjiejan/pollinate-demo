from flask_sqlalchemy import SQLAlchemy
from .pol import PolRepository


db = SQLAlchemy()
__all__ = ['PolRepository']
