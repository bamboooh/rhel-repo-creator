#!/bin/bash

# スクリプト名: createRepositry3_rh7.sh
# 作成者: 大竹　貴裕
# 作成日: 2024-04-10
# 概要：RHEL7用リポジトリ取得
#   rhel-7-server-rpms
#   rhel-7-server-extras-rpms
#   rhel-7-server-dotnet-rpms
#   epel

today=$(date "+%Y%m%d")
echo "today is ${today}."

# ログファイルへのパスを変数として設定
log_file="/opt/repository/log/${today}.log"

# mkdir
mkdir -p /opt/repository/${today}/repos/

# yuminstall
echo "必要パッケージ ダウンロード開始：$(date "+%T")" >> $log_file
yum install yum-utils createrepo genisoimage epel-release -y >> $log_file 2>&1
echo "必要パッケージ ダウンロード終了：$(date "+%T")" >> $log_file

# reposync
echo "rhel-7-server-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 -r rhel-7-server-rpms -d -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "rhel-7-server-rpmsダウンロード終了：$(date "+%T")" >> $log_file

echo "rhel-7-server-extras-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 -r rhel-7-server-extras-rpms -d -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "rhel-7-server-extras-rpmsダウンロード終了：$(date "+%T")" >> $log_file

echo "rhel-7-server-dotnet-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 -r rhel-7-server-dotnet-rpms -d -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "rhel-7-server-dotnet-rpmsダウンロード終了：$(date "+%T")" >> $log_file

echo "epelダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 -r epel -d -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "epelダウンロード終了：$(date "+%T")" >> $log_file

# createrepo
echo "rhel-7-server-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --checkts --update --workers=2 -g /opt/repository/${today}/repos/rhel-7-server-rpms/comps.xml /opt/repository/${today}/repos/rhel-7-server-rpms >> $log_file 2>&1
echo "rhel-7-server-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "rhel-7-server-extras-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --checkts --update --workers=2 -g /opt/repository/${today}/repos/rhel-7-server-extras-rpms/comps.xml /opt/repository/${today}/repos/rhel-7-server-extras-rpms >> $log_file 2>&1
echo "rhel-7-server-extras-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "rhel-7-server-dotnet-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --checkts --update --workers=2 -g /opt/repository/${today}/repos/rhel-7-server-dotnet-rpms/comps.xml /opt/repository/${today}/repos/rhel-7-server-dotnet-rpms >> $log_file 2>&1
echo "rhel-7-server-dotnet-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "epelリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --checkts --update --workers=2 -g /opt/repository/${today}/repos/epel/comps.xml /opt/repository/${today}/repos/epel >> $log_file 2>&1
echo "epelリポジトリ作成終了：$(date "+%T")" >> $log_file

# mkisofs
echo "イメージファイル作成開始：$(date "+%T")" >> $log_file
mkisofs -R -d -l -N -L -o /opt/repository/${today}/repos${today}_RHEL7.iso /opt/repository/${today}/ >> $log_file 2>&1
echo "イメージファイル作成終了：$(date "+%T")" >> $log_file

echo "md5sum値取得開始：$(date "+%T")" >> $log_file
md5sum /opt/repository/${today}/repos${today}_RHEL7.iso >> $log_file 2>&1
echo "md5sum値取得終了：$(date "+%T")" >> $log_file
