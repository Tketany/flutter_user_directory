# Flutter User Directory

## Approach

The application is structured into three main layers:

- **Models** (`lib/models`)  
  Contain the data models (`User`, `Address`, `Company`) used to represent API responses.  
  Each model includes a `fromJson` factory constructor to convert JSON data into strongly typed objects.

- **Services** (`lib/services`)  
  Responsible for API communication. The `UserService` handles the HTTP request to fetch users and converts the response into model objects.

- **Screens** (`lib/screens`)  
  Contain the UI components (`UserListScreen` and `UserDetailScreen`).  
  The UI interacts with the service layer to retrieve and display data.

State management is implemented using Flutter's built-in **`setState`**, which is sufficient for this small application.

---

## How to Run the App

```bash
flutter pub get
flutter run


## How to run the tests
flutter test
```
---

## Limitations
- The app uses the public JSONPlaceholder API, which provides mock data.
- Favorite users are stored in memory only and will reset when the app restarts.
- No external state management libraries were used to keep the implementation simple.