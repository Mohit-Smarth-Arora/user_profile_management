# 📱 User Profile Management App

A **Flutter application** that lets users securely log in, manage their personal profile details, and store data in **Supabase** — all with a clean and modern interface.

---

## ✨ Features

### 🔐 Authentication  
- ✅ **Google Sign-In** (secure and quick)  
- 🧾 Automatically creates a user in **Firebase** on first login

### 👤 Profile Management  
- 📧 View user email and basic info (from Google)  
- 📝 Edit and save personal details:
  - 🏠 Address  
  - 📞 Phone number
  - 🎂 Age (dropdown selector)  
  - 💬 Custom notes

- 💾 Data is persisted in **Supabase**

### 🚀 Navigation & UI  
- 🏠 Clean Home Screen with profile editing  
- 📂 Navigation drawer or menu to access other screens  
- ⚙️ Account settings and options
- ## 🖼️ App in Action

A quick glimpse at the app interface:
<p align="center">
  <img src="https://drive.google.com/uc?id=1SvlRpcoTHcOXW525n0OPPvp9YmputUvw" width="200" />
  <img src="https://drive.google.com/uc?id=1i4YULwmnq7xriFJ1u_j9U4_l6SiAjd7F" width="200" />
  <img src="https://drive.google.com/uc?id=1pG9im29EfhnVqH1w7bsPxXOWK1EP5eGj" width="200" />
</p>
<p align="center">
  <img src="https://drive.google.com/uc?id=1yKLMGCi29tmPmgZWXyDuRV4bFic20wUs" width="200" />
  <img src="https://drive.google.com/uc?id=1mQYVbN2bS88FfIaCaK6UJnTaaxOnzotA" width="200" />
  <img src="https://drive.google.com/uc?id=1aMzHRFfU-gUrwTcfuWfjXHhctgP87U1r" width="200" />
</p>

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

### 📥 Installation

```bash
git clone https://github.com/your-username/user-profile-app.git
cd user-profile-app
flutter pub get
```


