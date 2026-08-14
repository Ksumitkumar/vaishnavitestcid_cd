name: Flutter CI/CD

on:
pull_request:
branches:
- main
- master

push:
branches:
- main
- master
- develop

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

- name: Flutter version
run: flutter --version

- name: Install dependencies
run: flutter pub get

- name: Build APK
run: flutter build apk --release --split-per-abi

- name: Upload APK
uses: actions/upload-artifact@v4
with:
name: android-apks
path: build/app/outputs/apk/release/*.apk

  release:
    name: Create GitHub Release
    runs-on: ubuntu-latest
    needs: build

    if: >
      github.event_name == 'push' &&
      (github.ref == 'refs/heads/main' ||
       github.ref == 'refs/heads/master')

    permissions:
      contents: write

    steps:
      - name: Download APK
        uses: actions/download-artifact@v4
        with:
          name: android-apks
          path: apk

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          tag_name: v1.0.${{ github.run_number }}
          name: Release v1.0.${{ github.run_number }}
          files: apk/*.apk
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}