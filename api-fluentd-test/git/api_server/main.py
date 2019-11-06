# coding:utf-8

# これは外部のリクエストをさばく、api-serverの役割を果たす。
from bottle import template, run, route, request
import urllib
import os

# test
@route('/hello')
def test():
    print("hello")
    return "hello"

# テキスト
# htmlファイルを返す関数
@route('/text')
def show_text_main_page():
    return template('text_login')

# postされた情報を加えたhtmlファイルを返す関数
@route('/text/check', method='POST')
def test():
    username = request.forms.get('username')
    email = request.forms.get('email')

    return template("text_check", username=username, email=email)

# 画像
# htmlファイルを返す関数
@route('/photo')
def show_photo_main_page():
    return template('photo_login')

# postされた画像のバイナリデータを表示
@route('/photo/check', method='POST')
def check():
    photo_data = request.files.get('photo')
    photo_bin = photo_data.file
    return photo_bin

run(host='0.0.0.0', port=8080, debug=True)
