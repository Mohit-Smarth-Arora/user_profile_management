# 📱 User Profile Management App

A **Flutter application** that lets users securely log in, manage their personal profile details, and store data in **Supabase** — all with a clean and modern interface.

---

## ✨ Features

### 🔐 Authentication  
- ✅ **Google Sign-In** (secure and quick)  
- 📱 **Phone Number Login** *(optional bonus feature)*  
- 🧾 Automatically creates a user in **Firebase** on first login

### 👤 Profile Management  
- 📧 View user email and basic info (from Google)  
- 📝 Edit and save personal details:
  - 🏠 Address (with validation)  
  - 📞 Phone number (validated)  
  - 🎂 Age (dropdown selector)  
  - 💬 Custom notes

- 💾 Data is persisted in **Supabase**

### 🚀 Navigation & UI  
- 🏠 Clean Home Screen with profile editing  
- 📂 Navigation drawer or menu to access other screens  
- ⚙️ Account settings and options

### 🔐 Account Controls  
- 🔓 **Logout** securely  
- ❌ **Delete Account** (clears all associated data from Supabase)

---

## 🛠 Tech Stack

| Layer          | Technology           |
|----------------|----------------------|
| **Frontend**   | Flutter (Dart)       |
| **State Mgmt** | Riverpod             |
| **Auth**       | Firebase Auth        |
| **Database**   | Supabase             |

### 📦 Key Packages  
- [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) – reactive state management  
- [`supabase_flutter`](https://pub.dev/packages/supabase_flutter) – Supabase integration  
- [`firebase_auth`](https://pub.dev/packages/firebase_auth) – authentication with Google/Phone

---

## 🧰 Setup Instructions

### ✅ Prerequisites  
Make sure you have the following installed:
- Flutter SDK (latest stable)
- Dart SDK
- Firebase project setup
- Supabase project setup

### 📥 Installation

```bash
git clone https://github.com/your-username/user-profile-app.git
cd user-profile-app
flutter pub get
```

### 🔧 Configuration

1. **Firebase**:
   - Enable Google Sign-In and Phone Authentication
   - Download `google-services.json` and place it in `android/app/`

2. **Supabase**:
   - Create a table `user_details` with fields like `user_id`, `address`, `phone`, `age`, `notes`
   - Set up row-level security (RLS) using policies like:
     ```sql
     user_id = auth.uid()
     ```

3. **Environment Setup**:
   Add your keys in `lib/secrets.dart` or use `.env` via `flutter_dotenv`.

---

## 🚀 Run the App

```bash
flutter run
```

---

## 🙌 Contributions & Feedback

Pull requests are welcome! For major changes, please open an issue first to discuss what you’d like to change.  
Have feedback? Drop a star ⭐ and suggest ideas!
