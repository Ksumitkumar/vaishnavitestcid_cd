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