import datetime
import os
import time

import flask
from flask import request, send_file, abort
from flask_cors import CORS
from werkzeug.utils import secure_filename

app = flask.Flask(__name__)
CORS(app)
ALLOWED_EXTENSIONS = {'png', 'jpg'}


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/upload', methods=['POST'])
def post():
    print(request.files)
    print(request)
    if 'image' not in request.files:
        return 'no file'
    file = request.files['image']
    print(file.filename)
    if file.filename == '':
        return 'empty file name'
    if file and allowed_file(file.filename):
        now = int(time.mktime(datetime.datetime.now().timetuple()))
        fileArr = file.filename.split('.')
        filename = '{}_{}.{}'.format(secure_filename(fileArr[0]), now, fileArr[1])
        print(filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        return filename
    return 'bad'


@app.route('/images/<img>', methods=['GET'])
def get(img):
    file = os.path.join(app.config['UPLOAD_FOLDER'], img)    
    if os.path.exists(file):
        type = img.split('.')[1]
        return send_file(file, mimetype='image/{}'.format(type))
    
    abort(404)
    

app.config['UPLOAD_FOLDER'] = './static'

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=int("5000"), debug=True, use_reloader=False)
