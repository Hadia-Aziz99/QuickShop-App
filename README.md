# QuickShop – Shopping Mobile Application
**Mobile Computing Practical Assignment 1 (20 Marks)**

QuickShop is a modern, responsive, and beginner-friendly e-commerce shopping mobile application built using **Flutter and Dart**. It demonstrates core mobile computing concepts including navigation, gestures, animations, local in-memory state management, and webview integration with a modern lavender, purple, soft pink, and white color scheme.

---

## 📱 Features & Assignment Marking Breakdown (20 Marks)

| Requirement | Description | Marks | Status |
|---|---|---|---|
| **1. Splash Screen** | App name, shopping bag logo, welcome slogan, auto-navigation after 2.5s delay | **2 Marks** | ✅ Completed |
| **2. Home Screen & Navigation Drawer** | AppBar, Navigation Drawer (Home, Products, Add Product, WebView, Gestures), Card grid with image/price/name/details | **3 Marks** | ✅ Completed |
| **3. Product Details Screen** | Dedicated product page, full description, price, category, quantity counter, Add to Cart with SnackBar confirmation | **2 Marks** | ✅ Completed |
| **4. Add New Product** | Form with Name, Price, Description, Category fields. Validations (positive price, required fields), in-memory List update, auto-clear fields | **3 Marks** | ✅ Completed |
| **5. Gestures Implementation** | All 5 gestures implemented on Product Cards & dedicated Playground (`onTap`, `onDoubleTap`, `onLongPress`, `onHorizontalDrag`, `onVerticalDrag`) | **3 Marks** | ✅ Completed |
| **6. Animated Widget** | User-interactive `AnimatedContainer` and `AnimatedOpacity` (promotional banner and coupon reveal) | **2 Marks** | ✅ Completed |
| **7. State Management – Counter** | Quantity selector & Cart items counter with Increment/Decrement and immediate UI updates using `setState()` | **2 Marks** | ✅ Completed |
| **8. WebView Integration** | In-app browser screen using `webview_flutter`, public URL loading, back/reload navigation, and Android Internet permission | **3 Marks** | ✅ Completed |
| **Total** | | **20 Marks** | **100% Complete** |

---

## 🎨 UI/UX Design Palette
- **Deep Navy Blue:** `#0F172A` (AppBar, Main Headers, Primary Accents)
- **Rich Purple:** `#7C3AED` (Interactive Buttons, Highlights, Cart Badges)
- **Soft Lavender:** `#EDE9FE` (Tag Backgrounds, Circular Icon Containers)
- **Clean Off-White:** `#F8FAFC` (App Scaffold Background)
- **Pure White:** `#FFFFFF` (Cards, Inputs, Dialogue Surfaces)
- **Subtle Grey:** `#E2E8F0` / `#94A3B8` (Borders & Hints)

---

## 📂 Project Structure
```text
quickshop/
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml   <-- Includes android.permission.INTERNET
├── lib/
│   ├── data/
│   │   └── product_data.dart     <-- In-memory Dart List of initial products
│   ├── models/
│   │   └── product.dart          <-- Product data model
│   ├── screens/
│   │   ├── splash_screen.dart    <-- Splash screen with auto navigation
│   │   ├── home_screen.dart      <-- Home screen & Navigation Drawer
│   │   ├── product_details_screen.dart <-- Details screen & Quantity counter
│   │   ├── add_product_screen.dart    <-- Form to add new products
│   │   ├── gestures_screen.dart       <-- 5 Gestures, Animations & Counter
│   │   └── webview_screen.dart        <-- In-app webview integration
│   └── main.dart                 <-- App entry point & theme setup
├── test/
│   └── widget_test.dart          <-- Smoke tests for QuickShop
└── pubspec.yaml                  <-- Dependencies (webview_flutter, etc.)
```

---

## 🚀 How to Run the Application

### 1. Prerequisites
- Flutter SDK (v3.13 or higher)
- Android Studio / VS Code with Flutter extension
- Android Emulator or Physical Android Device

### 2. Steps to Run
```bash
# Navigate to the quickshop directory
cd quickshop

# Fetch dependencies
flutter pub get

# Check for any code issues
flutter analyze

# Run unit & widget tests
flutter test

# Run the app on an emulator or connected device
flutter run
```

---

## 🖐️ Gesture Instructions Guide
You can test the 5 gestures either directly on the **Product Cards** on the Home Screen, or by opening the **Gestures & Animation** screen from the Navigation Drawer:
1. **`onTap`**: Tap any product card to navigate to its Product Details screen.
2. **`onDoubleTap`**: Double-tap a product card to toggle it as a favourite with a confirmation SnackBar (`❤️`).
3. **`onLongPress`**: Press and hold a card for 1 second to view quick specs in a Bottom Sheet modal.
4. **`onHorizontalDrag`**: Swipe left or right across a product card to detect horizontal swiping with velocity info.
5. **`onVerticalDrag`**: Drag up or down across a product card to detect vertical dragging with direction feedback.
