# PUSHKA

**PUSHKA** is a reading management iOS application that helps users organize and track the books they are reading.

Users can search books using the Google Books API and add them to their personal bookshelf. The app features a dynamic **carousel-based bookshelf UI**, detailed book views, and persistent storage using Core Data.

The goal of the project was to explore advanced **SwiftUI layout techniques**, API integration, and local data persistence.

---

## Key Highlights

- Interactive **book carousel UI**
- Dynamic **background transitions based on selected book**
- Search books using Google Books API
- Persistent storage using Core Data
- Built fully using **SwiftUI**





## 📱 Screenshots

### Bookshelf Screen

The main screen shows books in a **carousel-style layout** with filters for reading status.

<img src="Screenshots/HomeScreen.png" width="300"/>

---

### Book Detail Screen

Displays detailed information about the selected book.

<img src="Screenshots/BookDetail.png" width="300"/>




# ✨ Features

- 🔎 Search books using Google Books API
- 📚 Add books to your personal bookshelf
- 🎠 Interactive book carousel
- 🗂 Filter books by reading status
  - Want to Read
  - Currently Reading
  - Read
- 📖 Detailed book information screen
- 💾 Persistent storage using Core Data


# 🛠 Tech Stack

**Language**
- Swift

**Framework**
- SwiftUI

**Architecture**
- MVVM

**Networking**
- URLSession
- Google Books API

**Persistence**
- Core Data

**Tools**
- Xcode
- Git

## Book Carousel

<table>
<tr>
<td width="60%">

The bookshelf uses a custom carousel implementation built with **SwiftUI's GeometryReader**.

### Behavior

- The **center book scales up** to highlight the selected book  
- Books on the sides shrink to create a **depth effect**  
- The **background dynamically updates** to the cover image of the centered book  
- Book covers are **loaded asynchronously from URLs returned by the Google Books API**

### SwiftUI Techniques Used

- `GeometryReader` for layout-based scaling effects
- `AsyncImage` for loading book cover images from remote URLs
- `ScrollView` for horizontal scrolling
- Dynamic scaling transformations based on view position

### Image Loading

Book cover images are fetched using the **Google Books API**.  
Each book provides a **thumbnail URL**, which is rendered using SwiftUI’s `AsyncImage`.

</td>

<td width="40%">

<a href="Screenshots/PUSHkaScroll.mov">
  <img src="Screenshots/HomeScreen.png" width="260">
</a>

</td>
</tr>
</table>
