import logging
from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from src.resources import (
    IPAddressClass,
    HealthClass,
)
from src.config import POSTGRES

app = Flask(__name__)

stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.WARNING)
app.logger.addHandler(stream_handler)

cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

app.config[
    'SQLALCHEMY_DATABASE_URI'] = 'postgresql://%(user)s:%(pw)s@%(host)s:%(port)s/%(db)s' % POSTGRES
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True  # To allow flask


@app.before_first_request
def create_tables():
    """
    This lines of code will make sure that before the first
    call to the database, the `database structure` is being
    created automatically.
    :return:
    """
    from src.db import db
    with app.app_context():
        db.init_app(app)
        db.create_all()


api = Api(app)
api.add_resource(IPAddressClass, '/api/ipaddress')
api.add_resource(HealthClass, '/api/health')

if __name__ == '__main__':
    app.run()
