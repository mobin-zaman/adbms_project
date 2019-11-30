from flask import Flask

from flask_restful import Api


app = Flask(__name__)

api = Api(app)


if __name__ = "__main__":
    app.run('0.0.0.0', port=5000, debug=True)
