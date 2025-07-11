# NewsPanel
Build a lightweight iOS application that simulates basic functionalities of a news panel app.

# 📱 AirFi iOS Developer Technical Assessment

This is a SwiftUI-based iOS application developed as part of the AirFi technical assessment.

---

## 🚀 Features

### ✅ Role-based Login
- `Robert` logs in as an **Author**
- Any other name logs in as a **Reviewer**

### ✅ News List
- **Author View**: Displays all articles authored by the user with approve count and full content.
- **Reviewer View**:
  - Displays grouped articles by author
  - Supports selection and bulk approval
  - Implements **pagination** (5 articles per batch)

### ✅ Sync Functionality
- **Before login**: Tap the Sync button to fetch articles from a mocked JSON API
- Stores metadata and full article content to **Core Data** (not UserDefaults)

### ✅ Offline Support
- All data is persisted locally
- App works without internet once synced

---

## 🗂 Technologies Used
- **Swift 5**
- **SwiftUI 3**
- **Core Data** for local storage
- **MVVM** architecture
- Mock APIs using delayed async methods

---

## 🧪 How to Run
1. Clone the repo
```bash
git clone https://github.com/your-username/airfi-assessment.git
```
2. Open `NewsPanel.xcodeproj` in Xcode (v13+)
3. Build and run the app
4. Tap **Sync** to load data before login
5. Log in as:
   - `Robert` → Author view
   - Any other name → Reviewer view

---

## 🧱 Project Structure
```
├── Models
│   ├── ArticleMetadata.swift
│   ├── ArticleDetail.swift
├── ViewModels
│   └── NewsListViewModel.swift
├── Views
│   ├── LoginView.swift
│   ├── NewsListView.swift
│   ├── AuthorListView.swift
│   └── ReviewerListView.swift
├── Services
│   └── NewsService.swift
├── Persistence
│   ├── PersistenceController.swift
│   └── StringArrayTransformer.swift
```

---

## 📄 Notes
- All data operations are done on Core Data
- Article detail and metadata are saved in separate entities
- Uses `StringArrayTransformer` for `[String]` Core Data support
- Designed for clarity, scalability, and offline-first access

---

## 📬 Author
**Dnyaneshwar Muley**  
[LinkedIn](https://www.linkedin.com/in/dmuley/)

---

Feel free to reach out for any clarification or walkthrough.

---
