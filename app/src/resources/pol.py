from flask import request, jsonify
from flask_restful import Resource
import os
from datetime import datetime

from repositories import PolRepository


class Pol(Resource):
    def get(self):
        """
        Create Timestamp
        """
        hostname: str = os.uname()[1]
        datetimestamp: str = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
        try:
            data = PolRepository.createtimestamp(hostname, datetimestamp)
            return data, 200
        except Exception as e:
            print(e)
            # response = jsonify(e.to_dict())
            # response.status_code = e.status_code
            return "error"

