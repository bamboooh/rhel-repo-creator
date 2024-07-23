# RHELローカルリポジトリ作成Shellスクリプト

## 説明
RHEL（Red Hat Enterprise Linux）のOSS（オープンソースソフトウェア）パッケージをローカル環境にインストールするためのリポジトリを作成するShellスクリプト

1. インターネットアクセスが可能なRHELでリポジトリ(ISOファイル)を作成
2. スタンドアローンの環境にリポジトリを転送
3. インストール用コマンド(yum/dnf)でインストール実施

## リポジトリ作成前の注意
- root権限で実施すること
- 公式のリポジトリが参照できるようにサブスクリプションを適用すること
- 公式のepelリポジトリより「epel-release.noarch」をインストールすること

## リポジトリの作成方法
### ディレクトリ作成
```sh
　mkdir /opt/repository/log
```

### shellを格納する　※環境のRHELバージョンのみで良い
　/opt/repository/createRepositry_rh7.sh
   - RHEL7以前 
   - 実行時間目安：約3時間
 
　/opt/repository/createRepositry_rh9.sh
- - RHEL9以降(検証していないがRHEL8もおそらく可)
- - 実行時間目安：約2時間半
    
 
### 実行
```sh
　cd /opt/repository
```
```sh
　nohup sh createRepositry_rh[x].sh &
```

## 作成したリポジトリの使用方法：
### ローカルリポジトリを適用するスタンドアローン環境にてコンフィグを格納する
 /etc/yum.repos.d/rhel[x]_local.repo
 
### 外部リポジトリを参照させないために/etc/yum.repos.d/*ファイル内全ての記載「enabled=1」→「enabled=0」
```sh
sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/*
```

### リポジトリ(ISOファイル)をマウントする
```sh
　mount /dev/sr0 /mnt
```
### 確認
```sh
　yum repolist
```
### 実行
```sh
　yum update
```
以上
