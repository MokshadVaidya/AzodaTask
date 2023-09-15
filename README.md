# Contact Form App

A simple Flutter application for managing contacts.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)


## Introduction

The Contact Form App is a Flutter application that allows users to manage their contacts. It provides features for adding, viewing, and editing contacts. This project serves as an example of how to build a Flutter app with Firebase integration and a clean architecture pattern.

## Features

- Add new contacts with name, phone number, address, and email.
- View a list of all contacts.
- Firebase integration for data storage.
- Clean architecture with the Bloc pattern.

## Project Structure

The project follows a modular and organized structure:

- `lib`: Contains the Flutter application code.
  - `features`: Contains feature modules.
    - `contacts`: The contacts feature module.
      - `data`: Data sources, repositories, and models related to contacts.
      - `domain`: Use cases and entities related to contacts.
      - `presentation`: Blocs, events, and screens related to contacts.
  - `utils`: Utility functions and constants used throughout the app.
  - `main.dart`: The entry point of the application.

## Dependencies

The project uses the following major dependencies:

- Flutter: The framework for building the mobile app.
- Firebase: For cloud-based data storage.
- Bloc: For state management using the Bloc pattern.
- Get It: For dependency injection.
- Lottie: For animations.


