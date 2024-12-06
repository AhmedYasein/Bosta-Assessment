# Bosta Assessment

This project is a **Bosta Assessment** application designed to fetch user details, albums, and photos from the **JSONPlaceholder API**. The app is built using **Swift**, **MVVM** design pattern, **Combine** for reactive programming, and **Moya** for API requests.

## Task Overview

In this task, we evaluate your coding style, design patterns, and ability to use appropriate technologies. The app consists of two screens:

### Screen 1: Profile Screen
- Displays the user's name and address at the top.
- Lists all the albums of the user. The albums are fetched from the `/albums` API endpoint using the `userId` parameter.

### Screen 2: Album Details Screen
- Displays photos in an Instagram-like grid.
- Fetches photos from the `/photos` API endpoint using the `albumId` parameter.
- Includes a search bar to filter images by their title. The list of images will dynamically update based on the search query.

## Software Stack

- **Swift**
- **MVVM** (Model-View-ViewModel design pattern)
- **Combine/RxSwift** for reactive programming
- **CombineCocoa/RxCocoa** for Cocoa bindings with Combine (or RxSwift)
- **UIKit** for UI design
- **Moya** for network requests
- **Swift Package Manager** for dependency management

## API Endpoints

- **Base URL**: `https://jsonplaceholder.typicode.com`
- **User**: `GET /users` — Retrieve the details of a user (you can pick any user, preferably random).
- **Albums**: `GET /albums` — Get the albums of a user by passing `userId` as a parameter.
- **Photos**: `GET /photos` — Get the photos of an album by passing `albumId` as a parameter.

## Screens

### Profile Screen

- Display the user's **name** and **address** at the top.
- List the **albums** for that user.
- Tap on an album to navigate to the **Album Details Screen**.

### Album Details Screen

- Display photos in a **grid layout** (similar to Instagram).
- Implement a **search bar** that filters images based on their **title**.
- **Dynamic updates** as the user types in the search bar.

## Bonus Feature

- Open any image in a separate **image viewer** with **zooming** and **sharing** functionality.

## Installation

### Clone the repository:

```bash
git clone https://github.com/yourusername/bosta-assessment.git
cd bosta-assessment
