# Alpha SuperApp

An Android super-app built with Jetpack Compose and MVVM, bundling AI-powered search, personal budget tracking, a gesture-controlled Bluetooth interface, and a calculator into one application.

## Features

- **Budget** — transaction tracking with Gmail and Esewa (.xls) statement parsing, receipt photo capture, duplicate detection, and Google Drive sync
- **Web Search** — natural-language and image-based (multimodal) search via Google Gemini
- **SBR Control** — real-time hand-gesture recognition (MediaPipe, 21-point landmarks) mapped to Bluetooth device commands, with temporal stability filtering
- **Calculator** — standard arithmetic calculator
- **Settings** — light/dark theme with system-sync or manual override, persisted via DataStore

## Tech Stack

- **Language**: Kotlin 2.2.10
- **UI**: Jetpack Compose (Material 3)
- **Architecture**: MVVM + Repository pattern, reactive state via Kotlin Flow/StateFlow
- **Build**: Gradle (Kotlin DSL), AGP 9.3.1
- **Networking/Parsing**: OkHttp, Gson, Apache POI (.xls)
- **Vision/Hardware**: MediaPipe Tasks Vision, CameraX, Android Bluetooth APIs
- **Persistence**: Android DataStore
- **Auth**: Google Play Services Auth (Drive)

## Requirements

- Android Studio (latest stable)
- JDK 11
- Android SDK: minSdk 26, targetSdk 36, compileSdk 36
- A Google Gemini API key (for Web Search)

## Setup

1. Clone the repository

   ```bash
   git clone https://github.com/Aaradhya-Dev-Tamrakar/Alpha-SuperApp.git
   ```

2. Add your Gemini API key to `local.properties` at the project root:

   ```properties
   GEMINI_API_KEY=your_gemini_api_key_here
   ```

3. Open in Android Studio and sync Gradle

## Build & Run

```bash
./gradlew build
./gradlew installDebug
```

Or use the **Run** button in Android Studio.

## Project Structure

```app/src/main/java/com/alpha/
├── core/
│   └── ai/              # GeminiClient — Gemini API integration
├── features/
│   ├── budget/          # ViewModel, Repository, parsers, Drive sync, models
│   ├── calculator/
│   ├── sbrcontrol/      # Gesture pipeline + Bluetooth communication
│   ├── settings/        # AppSettings (DataStore), theme state
│   └── websearch/
└── ui/
    ├── navigation/       # NavGraph
    ├── home/             # HomeScreen
    └── theme/            # Color, Theme, Type
```

See [CodeDescription.md](CodeDescription.md) for a full architectural breakdown of each module.

## Permissions

`INTERNET`, `CAMERA`, `BLUETOOTH`, `BLUETOOTH_CONNECT`, `BLUETOOTH_SCAN`

## Testing

```bash
./gradlew test
```

## Security

See [SECURITY.md](SECURITY.md) for responsible disclosure.

## License

MIT — see [LICENSE](LICENSE).

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## Contact

Aaradhya Dev Tamrakar — <aaradhyadevtmr@gmail.com>
