from sqlalchemy.exc import IntegrityError
from exceptions import ResourceExists
from models import Pol


class PolRepository:

    @staticmethod
    def createtimestamp(hostname: str, datetimestamp: str) -> dict:
        """ Create timestamp """
        result: dict = {}
        try:
            pol = Pol(hostname=hostname, datetimestamp=datetimestamp)
            pol.save()
            result = {
                'hostname': pol.hostname,
                'datetimestamp': pol.datetimestamp,
            }
        except IntegrityError:
            raise ResourceExists('error')

        return result

