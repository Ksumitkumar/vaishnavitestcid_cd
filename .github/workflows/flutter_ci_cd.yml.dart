name: Flutter CI/CD

on:
push:
branches:
- main

pull_request:
branches:
- main

jobs:
test:
name: Test Flutter App
runs-on: ubuntu-latest

steps:
- name: Checkout code
uses: actions/checkout@v4

- name: Setup Flutter
uses: subosito/flutter-action@v2
with:
channel: stable
cache: true

- name: Flutter version
run: flutter --version

- name: Install dependencies
run: flutter pub get

- name: Analyze code
run: flutter analyze

- name: Run tests
run: flutter test

build:
name: Build Android APK
runs-on: ubuntu-latest
needs: test

steps:
- name: Checkout code
uses: actions/checkout@v4

- name: Setup Flutter
uses: subosito/flutter-action@v2
with:
channel: stable
cache: true

- name: Install dependencies
run: flutter pub get

- name: Build APK
run: flutter build apk --release

- name: Upload APK
uses: actions/upload-artifact@v4
with:
name: release-apk
path: build/app/outputs/flutter-apk/app-release.apk