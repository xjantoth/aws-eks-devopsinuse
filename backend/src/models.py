"""This is a database model for IP ADDRESS store"""
import pytz
import datetime
from src.db import db


class IPAddress(db.Model):
    __tablename__ = 'ip_address'

    id = db.Column(db.Integer, primary_key=True)
    created = db.Column(
        db.DateTime,
        default=datetime.datetime.now(pytz.timezone("America/New_York"))
        )
    ipaddress = db.Column(db.String)

    def __init__(self, ipaddress, created):
        """

        :param ipaddress:
        :param created:
        """
        self.ipaddress = ipaddress
        self.created = created

    def json(self):
        return {
            "id": self.id,
            "created": str(self.created),
            "ipaddress": self.ipaddress,
        }

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    def save(self):
        db.session.add(self)
        db.session.commit()
        return self.json()
            
    @classmethod
    def find_address_by_id(cls, id):
        """

        :param ip:
        :return:
        """
        return cls.query.filter_by(id=id).first()

    @classmethod
    def list(cls):
        """

        :return:
        """
        return cls.query.all()
        


