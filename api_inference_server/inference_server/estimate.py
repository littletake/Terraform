# 学習済みモデルを利用した推論プログラム
# 関数化する

import chainer.links as links
import matplotlib.pyplot as plt
from chainer import serializers
from PIL import Image

# モデルのクラス
from functions import MLP
# 作成した関数群
from functions import convert_img, draw_digit, predict


def analyse(img):
    # 分類器インスタンスの生成（これがないとモデルを読み込めない）
    # Classifier クラスは定義したニューラルネットを分類器として簡単に利用するためのクラス
    # MLPクラスのインスタンスを引数として渡す
    model = links.Classifier(MLP())

    # modelのよみこみ
    # (file_name, 読み込みたいモデルに与える変数名)
    serializers.load_npz('mnist.model', model)

    # ここから画像を変形して分析に入る
    data_img = convert_img(img)
    draw_digit(data_img)
    result = predict(model, data_img)
    return result