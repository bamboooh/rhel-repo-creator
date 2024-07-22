RHELローカルリポジトリ作成用Shellスクリプト

説明：RHEL用に作成されてたOSSパッケージをローカル環境でインストールするために使用するリポジトリ作成するためのShellスクリプト
　　　　１．インターネットアクセスが可能なRHELでリポジトリを作成
    　　２．スタンドアローンの環境にリポジトリを転送
      　３．インストール用コマンド(yum/dnf)でインストール実施

注意：
公式のepelリポジトリより「epel-release.noarch」をインストールすること

■リポジトリ作成
使用方法：
以下のディレクトリを作成する
　mkdir /opt/repository/log

shellを格納する　※環境のRHELバージョンのみで良い
　/opt/repository/createRepositry_rh7.sh　※RHEL7以前
　/opt/repository/createRepositry_rh9.sh　※RHEL9以降(検証していないがRHEL8も可)

実行コマンド
　cd /opt/repository
　nohup sh createRepositry_rh[x].sh &

■作成したリポジトリの使用方法：
ローカルリポジトリを適用する環境にてコンフィグを格納する
　/etc/yum.repos.d/rhel_local.repo
　　※外部リポジトリを参照させないために/etc/yum.repos.d/*のファイル全てに記載されている「enabled=1」の記載を「enabled=0」にする

確認コマンド
　yum repolist

実行コマンド
　yum update

以上
