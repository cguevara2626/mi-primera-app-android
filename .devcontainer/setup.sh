#!/bin/bash
set -e

echo "Instalando dependencias del sistema..."
apt-get update && apt-get install -y wget unzip curl

echo "Configurando Android SDK..."
export ANDROID_HOME=/opt/android-sdk
mkdir -p ANDROID_HOME/cmdline-tools/latest
cd ANDROID_HOME

wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdlinetools.zip
unzip -q cmdlinetools.zip
mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true

export PATH=ANDROID_HOME/cmdline-tools/latest/bin:ANDROID_HOME/platform-tools:PATH
echo 'export ANDROID_HOME=/opt/android-sdk' >> /etc/bash.bashrc
echo 'export PATH=ANDROID_HOME/cmdline-tools/latest/bin:ANDROID_HOME/platform-tools:PATH' >> /etc/bash.bashrc

yes | sdkmanager --licenses >/dev/null 2>&1
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" >/dev/null 2>&1

echo "Instalando Gradle 8.2..."
cd /tmp
wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip -O gradle-8.2-bin.zip
unzip -q gradle-8.2-bin.zip -d /opt/
ln -sf /opt/gradle-8.2/bin/gradle /usr/local/bin/gradle
rm gradle-8.2-bin.zip

echo "Entorno listo: Android SDK 34 + Gradle 8.2 + Java 17"

