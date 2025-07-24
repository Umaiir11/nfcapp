# 🔥 NFC App - Flutter + Native Android Integration

A blazing fast Flutter app for reading and writing NFC tags with **MethodChannel magic** 🪄 to handle Android NFC intents, avoid app restarts, and support **MifareClassic**, **NDEF**, and more — all in a clean, DRY, and scalable architecture.

---

## 🚀 Features

- 📲 **Read NFC Tags**  
  Seamlessly read NDEF data or raw tag IDs using polling or Android intent triggers.

- ✍️ **Write NFC Tags**  
  Write text to NDEF-compatible tags with UTF-8 support.

- 🔌 **MethodChannel Bridge**  
  Connects Android NFC intents to Flutter in real-time for background tag processing.

- 🔒 **Prevent App Restarts**  
  Uses `launchMode="singleTask"` and foreground dispatch to ensure smooth, uninterrupted reads.

- 🛠️ **Robust Error Handling**  
  Handles unsupported tags, disconnections, and retries gracefully.

- 🧠 **Clean Architecture**  
  Based on **LayerX** pattern and **GetX**, ensuring clean separation of logic.

- 📜 **Detailed Logs**  
  Prints helpful logs (tag info, payloads, intent status) for debugging and analytics.

---

## 📦 Requirements

- ✅ Flutter SDK `3.0.0+`
- ✅ Android device with **NFC support**
- ✅ [`flutter_nfc_kit`](https://pub.dev/packages/flutter_nfc_kit) `^3.6.0+`
- ✅ Minimum Android SDK: `26+`

---

## 🛠 Installation

```bash
cd nfc_app
flutter pub get
