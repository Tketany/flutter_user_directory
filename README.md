# Flutter User Directory

A Flutter app that displays a directory of users using the JSONPlaceholder API.

## Features
- Fetches users from: https://jsonplaceholder.typicode.com/users
- User list shows: full name, email, company name
- User details shows: name, username, email, phone, website, company (name + catch phrase), and address
- Loading indicator while fetching
- Error state with retry button
- Pull-to-refresh on the list screen

## Project Structure
- lib/models: typed models (no raw Map objects in the UI)
- lib/services: API layer (HTTP + parsing)
- lib/screens: UI screens

## How to Run
```bash
flutter pub get
flutter run