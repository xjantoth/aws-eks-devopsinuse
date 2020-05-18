"""This is a resource file for db-model: IpAddress"""

import pytz
import socket
import datetime
from flask_restful import Resource, request
from src.models import IPAddress


class HealthClass(Resource):
    """
    This is the API checks backend connectivity to database.
    """
    def get(self):
        """Connects to PostgreSQL database"""
        try:
            IPAddress.list()
            return {
                "msg": "Dummy database connectivity check.",
                "message": True,
            }, 200

        except Exception as e:
            return {"msg": f"Cloud not load data from database: {e}"}, 500


class IPAddressClass(Resource):
    """
    This is the API which will grab the IP address from running
    container and save it into the database.
    """
    def post(self):
        try:
            created_date = datetime.datetime.now(
                pytz.timezone("America/New_York"))
            ipaddress = socket.gethostbyname(socket.gethostname())
            ip = IPAddress(ipaddress=ipaddress, created=created_date)
            return ip.save(), 200

        except Exception as e:
            return {"msg": f"Cdold not save data into database. {e}"}, 500

    def get(self):
        """Retrives all IP Addresses from PostgreSQL database"""
        try:
            addresses = IPAddress.list()
            if len(addresses) > 0:
                return [{
                    "id": a.id,
                    "created": str(a.created),
                    "ipaddress": a.ipaddress
                } for a in addresses], 200

            return {"msg": "No IP Addresses found in database."}, 200

        except Exception as e:
            return {"msg": f"Cloud not load data from database: {e}"}, 500

    def delete(self):
        """Retrives all IP Addresses from PostgreSQL database"""
        try:
            args = request.args
            id = args["id"]
            ret = IPAddress.find_address_by_id(id)

            if ret is None:
                return {
                    "msg": f"Entry with id: {id} does not exist in database."
                }, 404

            IPAddress.find_address_by_id(id).delete()
            return {"msg": f"Entry with id: {id} deleted"}, 200

        except Exception as e:
            return {"msg": f"Cloud not delete data from database: {e}"}, 500
