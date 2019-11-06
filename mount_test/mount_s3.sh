#!/bin/bash

# 必要なアプリケーションを作る
sudo apt-get install automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config

# s3fs(マウント用のアプリケーション)をgitからインストール
git clone https://github.com/s3fs-fuse/s3fs-fuse.git

# 諸々の設定
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install

# マウントポイントの作成
sudo mkdir /mnt/s3

# マウントする
sudo s3fs test-terraform-take /mnt/s3 -o rw,allow_other,uid=1000,gid=1000,default_acl=public-read,iam_role=test_role
