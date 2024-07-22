RHELローカルリポジトリ作成用Shellスクリプト

説明：RHEL用に作成されてたOSSパッケージをローカル環境でインストールするために使用するリポジトリ作成するためのShellスクリプト
　　　　１．インターネットアクセスが可能なRHELでリポジトリを作成
    　　２．スタンドアローンの環境にリポジトリを転送
      　３．インストール用コマンド(yum/dnf)でインストール実施

以下のディレクトリを作成する
　/opt/repository/
　/opt/repository/log

shellを格納する
　/opt/repository/createRepositry_rh7.sh
　/opt/repository/createRepositry_rh9.sh

実行コマンド
　cd /opt/repository
　nohup sh createRepositry_rh[x].sh &

以上
