CRUD API consumption using http and state management using Provider

A clean, responsive user management application built with **Flutter**. 
This project demonstrates professional architectural patterns, including state management with **Provider** and RESTful API integration using the **http** package.

🚀 Overview
This application connects to the [DummyJSON API](https://dummyjson.com/) to perform full CRUD (Create, Read, Update, Delete) operations on user data. 
It is designed to handle asynchronous data fetching, local state updates, and real-time UI synchronization.

🛠️ Tech Stack & Architecture
Framework: [Flutter](https://flutter.dev/)
State Management: [Provider](https://pub.dev/packages/provider) – Used for centralized business logic and state propagation.
Networking: [http](https://pub.dev/packages/http) – Handles GET, POST, PATCH, and DELETE requests.
Data Modeling: Custom Dart classes with JSON serialization.

✨ Key Features
Live Data Fetching: Automatically retrieves a list of users from a remote server on startup.
State-Aware UI: Uses `Consumer` and `notifyListeners()` to ensure the UI updates instantly when data changes.
Optimistic UI Updates: Provides a smooth user experience during Create, Update, and Delete actions.
Error Handling: Basic handling for network requests and data parsing.

📂 Project Structure
 `lib/models/`: Contains the `User` data model.
 `lib/services/`: Contains the `ApiService` class for raw HTTP calls.
 `lib/providers/`: Contains the `UserProvider` for managing the application state.
 `lib/screens/`: Contains the UI layers and list views.

🔧 How to Run

Follow these steps to get the project running on your local machine:

```bash
# 1. Clone the repository
git clone [https://github.com/Yanet-Abreham/flutter-http-provider-crud.git](https://github.com/Yanet-Abreham/flutter-http-provider-crud.git)

# 2. Navigate into the project folder
cd flutter_provider_http

# 3. Install dependencies
flutter pub get

# 4. Run the application
flutter run
