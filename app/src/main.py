from flask_restful import Api
from resources import HealthCheck, Pol
from models import Pol as PolModel, db
from flask_migrate import Migrate
from app import create_app


app = create_app()
migrate = Migrate(app, db)


# API
api = Api(app)
api.add_resource(HealthCheck, '/healthcheck')
api.add_resource(Pol, '/api/pol')

# CLI for migrations
@app.shell_context_processor
def make_shell_context():
    return dict(app=app, db=db, Pol=PolModel)
