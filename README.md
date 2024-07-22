# RHELローカルリポジトリ作成用Shellスクリプト

## 説明
RHEL用に作成されてたOSSパッケージをローカル環境でインストールするために使用するリポジトリを作成するためのShellスクリプトです。

1. インターネットアクセスが可能なRHELでリポジトリ(ISOファイル)を作成
2. スタンドアローンの環境にリポジトリを転送
3. インストール用コマンド(yum/dnf)でインストール実施

## リポジトリ作成前の注意
- 公式のリポジトリが参照できるようにサブスクリプションを適用すること
- 公式のepelリポジトリより「epel-release.noarch」をインストールすること

## リポジトリ作成
### ディレクトリ作成
　mkdir /opt/repository/log

### shellを格納する　※環境のRHELバージョンのみで良い
　/opt/repository/createRepositry_rh7.sh　※RHEL7以前
　/opt/repository/createRepositry_rh9.sh　※RHEL9以降(検証していないがRHEL8もおそらく可)

### 実行
　cd /opt/repository
　nohup sh createRepositry_rh[x].sh &

## 作成したリポジトリの使用方法：
### ローカルリポジトリを適用するスタンドアローン環境にてコンフィグを格納する
　/etc/yum.repos.d/rhel_local.repo
　　※外部リポジトリを参照させないために/etc/yum.repos.d/*のファイル全てに記載されている「enabled=1」の記載を「enabled=0」にする

### リポジトリ(ISOファイル)をマウントする
　mount /dev/sr0 /mnt

### 確認
　yum repolist

### 実行
　yum update

以上
