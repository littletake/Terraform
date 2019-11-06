# bottle_server

from bottle import route, run
from bottle import request
import base64
import io
from PIL import Image
from estimate import analyse

# Test
@route('/')
def hello():
    return "hello"


# TestPhotoPost
@route('/photo_server', method='post')
def test():
    img_file = request.files.get("photo")

    # ファイルオブジェクトに変換し、PILで開ける
    img_bin = img_file.file
    img = Image.open(img_bin)
    result = analyse(img)

    # img.save("test.png", "PNG")
    # data = base64.b64decode(body)
    # i = Image.open(body)

    print(result)
    return str(result)

run(host='0.0.0.0', port=8080, debug=True)
