import chainer
import chainer.functions as functions
import chainer.links as links
import matplotlib.pyplot as plt
import numpy as np


# MLPクラス（学習モデルを定義する）
class MLP(chainer.Chain):
    # ニューラルネットの構造を定義
    def __init__(self):
        super(MLP, self).__init__()
        with self.init_scope():
            self.l1 = links.Linear(784, 900)
            self.l2 = links.Linear(900, 1000)
            self.l3 = links.Linear(1000, 500)
            self.l4 = links.Linear(500, 10)
            
    # ニューラルネットの計算規則を定義
    def __call__(self, x):
        h1 = functions.relu(self.l1(x))
        h2 = functions.relu(self.l2(h1))
        h3 = functions.relu(self.l3(h2))
        return self.l4(h3)


# 手書き文字変換の関数(sample_img = 読み込む写真)
def convert_img(sample_img):
    # 白黒反転と28*28にリサイズ
    sample_img_re = sample_img.convert('L').resize((28, 28))
    # array化と正規化
    array_sample_img = np.asarray(sample_img_re, dtype=np.float32)/255
    # 写真が白の場合の対応
    array_sample_img = 1 - array_sample_img
    train_img = []
    for x in range(28):
        for y in range(28):
            train_img.append(array_sample_img[x, y])
    train_img = np.array(train_img)
    return train_img


# データを画像として出力する関数
def draw_digit(data):
    plt.figure(figsize=(3, 3))
    x, y = np.meshgrid(range(28), range(28))
    z = data.reshape(28, 28)
    z = z[::-1, :]
    plt.pcolor(x, y, z)
    plt.tick_params(labelbottom='True')
    plt.tick_params(labelleft='False')
    plt.gray()
    plt.show()


# モデルを利用して予測をする関数を定義
def predict(model, x):
    # データ数が１の場合は、バッチサイズ分の次元を追加
    if len(x.shape) == 1:
        pred = model.predictor(x[None, ...]).data.argmax()
    # データ数が2以上の場合はそのまま
    else:
        pred = model.predicor(x).data.argmax(axis=1)
    return pred
