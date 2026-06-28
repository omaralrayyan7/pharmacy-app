# What is Pharmacy App?

## Overview

**Pharmacy App** is a Flutter-based e-commerce mobile and web application that simulates a full-featured online pharmacy store. Built as a university project, it lets users browse and add pharmacy products to a shopping cart across multiple categories, submit reviews, and contact the pharmacy. The app integrates **Firebase Authentication** for user sign-in/sign-up and **Cloud Firestore** for storing reviews and employee data.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Authentication | Firebase Auth (email/password) |
| Database | Cloud Firestore |
| State Management | Provider (ChangeNotifier) |
| Platform | Android, iOS, Web |
| Firebase Project | `shinya-f31ce` |

---

## Features

- **Firebase Auth** — Sign up (Full Name, Age, Email, Password) and Sign In with email/password
- **Home screen** — Auto-sliding banner carousel + category navigation buttons
- **Medicine page** — Browse medicines (Panadol, Tramal, etc.) with quantity selector and Add to Cart
- **Needles & Syringes page** — Medical injection supplies with cart support
- **Skincare page** — Cosmetics and skincare products with cart support
- **Shopping Cart** — Accumulated cart view with item totals
- **Contact Us** — Email, phone, and social media info
- **Review / Feedback** — 5-star rating + text review saved to Firestore
- **Admin: Add Employee** — Admin form to add employee name + phone to Firestore `datanew` collection
- **Admin: Employee List** — Real-time Firestore stream of employee records

---

## Project Structure

```
lib/
├── main.dart                      # App entry point, MaterialApp + routes
├── firebase_options.dart          # Auto-generated Firebase config
│
├── auth/                          # Authentication layer
│   ├── auth_service.dart          # Firebase Auth wrapper (signUp, signIn, signOut)
│   ├── auth_provider.dart         # ChangeNotifier: signUp + isLoading state
│   └── auth_notifier.dart         # ChangeNotifier: isAuthenticated state
│
└── screens/
    ├── auth/
    │   ├── sign_in.dart           # Sign In screen
    │   └── sign_up_page.dart      # Sign Up screen with form validation
    │
    ├── home/
    │   └── home_page.dart         # Home: carousel banner + category grid
    │
    ├── products/
    │   ├── medicine_page.dart     # Medicine products + cart
    │   ├── men_page.dart          # Needles & syringes + cart
    │   └── skincare_page.dart     # Skincare / cosmetics + cart
    │
    ├── cart/
    │   └── cart_page.dart         # Cart display with totals
    │
    ├── admin/
    │   ├── add_employee_page.dart # Add employee to Firestore
    │   └── employee_list_view.dart# Real-time Firestore employee list
    │
    ├── contact_us_page.dart       # Contact info (email, phone, social)
    └── review_page.dart           # 5-star rating + feedback to Firestore
```

---

## App Routes

| Route | Screen | Description |
|---|---|---|
| `/` | `SignInPage` | Email + password login |
| `/signup` | `SignUpPage` | Registration with validation |
| `/view` | `HomePage` | Banner carousel + category buttons |
| `/medicine` | `MedicinePage` | Medicine product list + cart |
| `/men` | `MenPage` | Needles & syringes + cart |
| `/shoes` | `SkincarePage` | Skincare products + cart |
| `/contact` | `ContactUsPage` | Contact info |
| `/FeedBack` | `ReviewPage` | Star rating + Firestore review |
| `/Add` | `AddEmployeePage` | Admin: add employee |

---

## Key Code Segments

### Firebase Initialization (`main.dart`)
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
      child: const MyApp(),
    ),
  );
}
```

### Auth Service (`auth/auth_service.dart`)
```dart
Future<String?> signUp(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return 'Sign Up Successful!';
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}
```

### Review Submission (`screens/review_page.dart`)
```dart
await FirebaseFirestore.instance.collection('reviews').add({
  'rating': _selectedRating,
  'description': description,
  'timestamp': FieldValue.serverTimestamp(),
});
```

### Admin: Save Employee (`screens/admin/add_employee_page.dart`)
```dart
final CollectionReference employees =
    FirebaseFirestore.instance.collection('datanew');

await employees.add({'name': firstname, 'phone': phone});
```

### Real-time Firestore Stream (`screens/admin/employee_list_view.dart`)
```dart
Stream<QuerySnapshot> getEmployeeData() {
  return employees.snapshots(); // listens to real-time Firestore updates
}
```

---

## Firebase Project Details

- **Project ID:** `shinya-f31ce`
- **Auth Domain:** `shinya-f31ce.firebaseapp.com`
- **Firestore Collections:** `reviews`, `datanew`
- **Platforms configured:** Web, Android, iOS, macOS, Windows

---

## Future Enhancements

- Checkout and payment integration
- Product search and filtering
- User profile page
- Order history with Firestore
- Push notifications via Firebase Cloud Messaging
- Admin dashboard for inventory management
