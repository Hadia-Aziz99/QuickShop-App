# QuickShop – Shopping Mobile Application

**Mobile Computing Practical Assignment 1**

QuickShop is a modern, responsive, and beginner-friendly e-commerce shopping mobile application built using **Flutter and Dart**. It demonstrates core mobile computing concepts including navigation, gestures, animations, local in-memory state management, and WebView integration with a modern lavender, purple, soft pink, and white color scheme.

---

## 📱 Features

| Feature                                | Description                                                                                                                                                                 |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Splash Screen**                   | App name, shopping bag logo, welcome slogan, and automatic navigation after a 2.5-second delay.                                                                             |
| **2. Home Screen & Navigation Drawer** | AppBar, Navigation Drawer (Home, Products, Add Product, WebView, Gestures), and product card grid with images, prices, names, and details.                                  |
| **3. Product Details Screen**          | Dedicated product page with full description, price, image, category, quantity counter, and Add to Cart with SnackBar confirmation.                                         |
| **4. Add New Product**                 | Form with Name, Price, Description, and Category fields. Includes validation for required fields and positive prices, in-memory List updates, and automatic field clearing. |
| **5. Gestures Implementation**         | Five gestures implemented on Product Cards and a dedicated Playground: `onTap`, `onDoubleTap`, `onLongPress`, `onHorizontalDrag`, and `onVerticalDrag`.                     |
| **6. Animated Widgets**                | Interactive `AnimatedContainer` and `AnimatedOpacity` for promotional banners and coupon reveal.                                                                            |
| **7. State Management – Counter**      | Quantity selector and Cart items counter with Increment/Decrement functionality and immediate UI updates using `setState()`.                                                |
| **8. WebView Integration**             | In-app browser using `webview_flutter`, public website loading, back/reload navigation, and Android Internet permission.                                                    |

---

## 🎨 UI/UX Design Palette

- **Deep Navy Blue:** `#0F172A` – AppBar, Main Headers, Primary Accents
- **Rich Purple:** `#7C3AED` – Interactive Buttons, Highlights, Cart Badges
- **Soft Lavender:** `#EDE9FE` – Tag Backgrounds, Circular Icon Containers
- **Clean Off-White:** `#F8FAFC` – App Scaffold Background
- **Pure White:** `#FFFFFF` – Cards, Inputs, Dialogue Surfaces
- **Subtle Grey:** `#E2E8F0` / `#94A3B8` – Borders & Hints

---

## 📂 Project Structure

```text
quickshop/
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml
│           └── Includes android.permission.INTERNET
├── lib/
│   ├── data/
│   │   └── product_data.dart
│   │       └── In-memory Dart List of initial products
│   ├── models/
│   │   └── product.dart
│   │       └── Product data model
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── home_screen.dart
│   │   ├── product_details_screen.dart
│   │   ├── add_product_screen.dart
│   │   ├── gestures_screen.dart
│   │   └── webview_screen.dart
│   └── main.dart
│       └── App entry point & theme setup
├── test/
│   └── widget_test.dart
│       └── Smoke tests for QuickShop
└── pubspec.yaml
    └── Dependencies (webview_flutter, etc.)
```

---

## 🚀 How to Run the Application

### 1. Prerequisites

- Flutter SDK (v3.13 or higher)
- Android Studio / VS Code with Flutter extension
- Android Emulator or Physical Android Device

### 2. Steps to Run

Navigate to the QuickShop directory:

```bash
cd quickshop
```

Fetch dependencies:

```bash
flutter pub get
```

Check for any code issues:

```bash
flutter analyze
```

Run unit and widget tests:

```bash
flutter test
```

Run the application on an emulator or connected device:

```bash
flutter run
```

---

## 🖐️ Gesture Instructions Guide

You can test the five gestures either directly on the **Product Cards** on the Home Screen or by opening the **Gestures & Animation** screen from the Navigation Drawer.

1. **`onTap`:** Tap any product card to navigate to its Product Details screen.
2. **`onDoubleTap`:** Double-tap a product card to toggle it as a favourite with a confirmation SnackBar (❤️).
3. **`onLongPress`:** Press and hold a card for 1 second to view quick specifications in a Bottom Sheet modal.
4. **`onHorizontalDrag`:** Swipe left or right across a product card to detect horizontal swiping with velocity information.
5. **`onVerticalDrag`:** Drag up or down across a product card to detect vertical dragging with direction feedback.

---

**Developed as a Mobile Computing Practical Project using Flutter and Dart.**
