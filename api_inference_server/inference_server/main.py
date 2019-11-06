import numpy as np
import matplotlib.pyplot as plt
import chainer
import chainer.functions as F
import chainer.links as L
from chainer import computational_graph
from chainer import serializers
import functions

# 分類器インスタンスの生成（これがないとモデルを読み込めない）
# Classifier クラスは定義したニューラルネットを分類器として簡単に利用するためのクラス
# MLPクラスのインスタンスを引数として渡す
from functions import MLP
model = L.Classifier(MLP())

#modelのよみこみ
#(file_name, 読み込みたいモデルに与える変数名)

serializers.load_npz('mnist.model', model)

from PIL import Image
img = Image.open('num_9.jpg')
img.show()

from functions import convert_img
data_img = convert_img(img)
draw_digit(data_img)

result = predict(model, data_img)
print(result)
if(result == 9):
    print('GOOD')
else:
    print('NOOO')
