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

release:
name: Create GitHub Release
runs-on: ubuntu-latest
needs: build

# Only create a release when code is pushed to main.
# Do not create releases for Pull Requests.
if: github.event_name == 'push'

permissions:
contents: write

steps:
- name: Download APK
uses: actions/download-artifact@v4
with:
name: release-apk
path: apk

- name: Create GitHub Release
uses: softprops/action-gh-release@v2
with:
tag_name: v1.0.${{ github.run_number }}
name: Release v1.0.${{ github.run_number }}
files: apk/app-release.apk
env:
GITHUB_TOKEN: ${{ secrets.TOKEN }}