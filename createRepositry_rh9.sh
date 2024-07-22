#!/bin/bash

# スクリプト名: createRepositry4_rh9.sh
# 作成者: 大竹　貴裕
# 作成日: 2024-05-28
# 概要：RHEL9用リポジトリ取得
#   rhel-9-for-x86_64-baseos-rpms
#   rhel-9-for-x86_64-appstream-rpms
#   epel
#   codeready-builder-for-rhel-9-x86_64-rpms
# 備考：
#   ポジトリ取得シェルスクリプト修正メモ(RHEL 7 to RHEL 9)
#   RHEL 7とRHEL 9での主な違いは、リポジトリ名
#   RHEL 9では、rhel-7をrhel-9に更新し、RHEL 9に固有のリポジトリ名を使用
#   また、RHEL 9ではdotnetリポジトリがAppStreamリポジトリに統合されているため、dotnetリポジトリのセクションは必要ない

today=$(date "+%Y%m%d")
echo "today is ${today}."

# ログファイルへのパスを変数として設定
log_file="/opt/repository/log/${today}.log"

# mkdir
mkdir -p /opt/repository/${today}/repos/

# yuminstall
echo "必要パッケージ ダウンロード開始：$(date "+%T")" >> $log_file
yum install yum-utils createrepo_c genisoimage epel-release -y >> $log_file 2>&1
echo "必要パッケージ ダウンロード終了：$(date "+%T")" >> $log_file

# reposync
echo "rhel-9-for-x86_64-baseos-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 --repo rhel-9-for-x86_64-baseos-rpms -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "rhel-9-for-x86_64-baseos-rpmsダウンロード終了：$(date "+%T")" >> $log_file

echo "rhel-9-for-x86_64-appstream-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 --repo rhel-9-for-x86_64-appstream-rpms -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "rhel-9-for-x86_64-appstream-rpmsダウンロード終了：$(date "+%T")" >> $log_file

echo "epelダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 --repo epel -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "epelダウンロード終了：$(date "+%T")" >> $log_file

echo "codeready-builder-for-rhel-9-x86_64-rpmsダウンロード開始：$(date "+%T")" >> $log_file
reposync --downloadcomps --download-metadata --newest-only -a x86_64 --repo codeready-builder-for-rhel-9-x86_64-rpms -p /opt/repository/${today}/repos >> $log_file 2>&1
echo "codeready-builder-for-rhel-9-x86_64-rpmsダウンロード終了：$(date "+%T")" >> $log_file

# createrepo
echo "rhel-9-for-x86_64-baseos-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --update --workers=2 -g /opt/repository/${today}/repos/rhel-9-for-x86_64-baseos-rpms/comps.xml /opt/repository/${today}/repos/rhel-9-for-x86_64-baseos-rpms >> $log_file 2>&1
echo "rhel-9-for-x86_64-baseos-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "rhel-9-for-x86_64-appstream-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --update --workers=2 -g /opt/repository/${today}/repos/rhel-9-for-x86_64-appstream-rpms/comps.xml /opt/repository/${today}/repos/rhel-9-for-x86_64-appstream-rpms >> $log_file 2>&1
echo "rhel-9-for-x86_64-appstream-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "epelリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --update --workers=2 -g /opt/repository/${today}/repos/epel/comps.xml /opt/repository/${today}/repos/epel >> $log_file 2>&1
echo "epelリポジトリ作成終了：$(date "+%T")" >> $log_file

echo "codeready-builder-for-rhel-9-x86_64-rpmsリポジトリ作成開始：$(date "+%T")" >> $log_file
createrepo -s sha256 --update --workers=2 -g /opt/repository/${today}/repos/codeready-builder-for-rhel-9-x86_64-rpms/comps.xml /opt/repository/${today}/repos/codeready-builder-for-rhel-9-x86_64-rpms >> $log_file 2>&1
echo "codeready-builder-for-rhel-9-x86_64-rpmsリポジトリ作成終了：$(date "+%T")" >> $log_file

# mkisofs
echo "イメージファイル作成開始：$(date "+%T")" >> $log_file
mkisofs -R -d -l -N -L -o /opt/repository/${today}/repos${today}_RHEL9.iso /opt/repository/${today}/ >> $log_file 2>&1
echo "イメージファイル作成終了：$(date "+%T")" >> $log_file

echo "md5sum値取得開始：$(date "+%T")" >> $log_file
md5sum /opt/repository/${today}/repos${today}_RHEL9.iso >> $log_file 2>&1
echo "md5sum値取得終了：$(date "+%T")" >> $log_file

