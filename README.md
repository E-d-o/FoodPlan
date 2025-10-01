# Foodplan
A mobile app developed in Flutter in order to keep track of foods in various shopping lists.

## 🛠️ Tech stack

+ **Framework:** Flutter
+ **Language:** Dart
+ **Database:** Hive (NoSQL)
+ **State Management:** Provider

## ✨ Features
- Creation and management of foods and shopping lists.
- Custom food properties:price, quantity, unit of measure, expiration date, description
- Photo assignment to food via camera or gallery
- Autocomplete when adding items for faster input

## 📦 Installation guide
### Prerequisites
  - Flutter SDK installed and configured
  - Android device or emulator

### Build Steps
In order to install it's required to build the app,so **it's required to have setup a flutter enviroment.**
1) First clone this repo using:
 ```bash
 git clone https://github.com/E-d-o/FoodPlan.git
 ```
2) Navigate to the direcory:
```bash
cd foodplan
```
3) Run in the terminal:
 ```bash
 dart run build_runner build
 ```
4) With that done the next step is to build the app with
```bash
flutter build apk --target lib/pages/main.dart
```
5) The file will be at build/app/outputs/flutter-apk/app-release.apk, navigate there:
```bash
cd build/app/outputs/flutter-apk/
```

6) Transfer the app-realease.apk file to your android device
7) Install it using a file manager
