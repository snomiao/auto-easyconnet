@echo off
chcp 65001
REM Copyright © 2020 snomiao (snomiao@gmail.com)
REM 本脚本用于将本项目部署到服务器上

npx ftp-srv ftp://0.0.0.0:2121 --root .

REM 然后在服务器上打开 ftp://...:2121/ 即可部署

REM 注意用 FTP 部署可能会遇到 IE 缓存问题，见此
REM [Prevent Caching in Windows FTP (Explorer) - Super User]( https://superuser.com/questions/388917/prevent-caching-in-windows-ftp-explorer )