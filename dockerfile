#
# GhostDockWin Dockerfile
#
# https://github.com/mouse-man/GhostDockWin
#

# Pull base image.
FROM stefanscherer/node-windows

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install Ghost
RUN \
  New-Item -ItemType directory -Path C:\temp \
  cd C:\temp && \
  Invoke-WebRequest https://ghost.org/zip/ghost-latest.zip \
  Expand-Archive ghost-latest.zip -DestinationPath C:\temp
  Remove-Item ghost-latest.zip \
  cd ghost \
  npm install --production \
  (Get-Content config.example.js).replace('127.0.0.1','0.0.0.0') | Set-Content config.js \

# Expose ports.
EXPOSE 2368
