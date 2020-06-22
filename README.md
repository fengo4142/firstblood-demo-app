# Project description

This exercise is based on a Flutter starter tutorial.

The local development flow is

* Develop Flutter code using Visual Studio Code, or any of tools you wish

* Backend is Node.js / Express and can be run locally, instructions below

# Prerequisites

* You need to understand Flutter SDK, related mobile development tools, UNIX shell, Node.js

# Installation

* [Install Flutter and run Flutter doctor to ensure you have everything to run an app](https://flutter.dev/docs/get-started/install)

* We recommend using Visual Studio Code and Flutter extension for the development

# Development

## Running the app locally

* [Easiest way to run the application is using DevTools from Visual Studio Code](https://flutter.dev/docs/development/tools/devtools/vscode)
  and target Android emulator

* Run *Flutter Doctor* through Visual Studio Code command palette to ensure your editor is properly set up. You might need also do some extra setup.
  [Here are instructions for macOS](https://stackoverflow.com/questions/61036745/invalid-arguments-cannot-find-executable-for-null-when-emulated-android-on/61869002#61869002).

* Visual Studio Code will automatically detect the project. Go to VSCode Debug tab and hit the Play button next to *Run app (flutter_hiring_exercise)* and then choose Android emulator as target.

You can also run from the command line:

```sh
flutter emulators --launch flutter_emulator
flutter run
```

Make sure the backend process is running.

## Running tests

You can choose *Run all tests (flutter_hiring_exercise)* in Visual Studio Code.

Alternative you can run tests from the command line:

```sh
flutter test
```

## Running backend

You can run the backend by

```sh
cd backend
npm install
node index.js
```

Then you can test the server:

```sh
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"email": "example@example.com", "password":"secret"}' \
  http://localhost:3000/login
```

You should get a reply

```json
{"firstName":"John","lastName":"Appleseed","username":"flurryflutter","level":"100"}
```

Tested with Node v12.

# Further reading

[Flutter getting started](https://flutter.dev/docs/get-started/codelab)

