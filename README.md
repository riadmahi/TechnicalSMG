# **TechSMG – iOS Technical Test Project**

Welcome to TechSMG, a technical test project developed for the Swiss Marketplace Group as part of the iOS recruitment process. This project demonstrates my technical capabilities, product-oriented mindset, and focus on writing clean, testable, and maintainable SwiftUI code.

## **Motivation**

After receiving the email from Rohan Büchner, I approached this test with genuine commitment. I’m truly interested in SMG’s culture, technical standards, and the positive impact of its products. As a passionate mobile developer aiming to deepen my expertise in iOS, this project was an opportunity to demonstrate not only technical skills but also thoughtful architecture and pragmatic decision-making.

## **Project Overview**

The app allows users to:

- View a list of posts
- Tap into post details
- Create a new post using a form

Data is fetched from a placeholder API. The user experience is enriched with reusable components, modern fonts, and localized strings.

## **Architecture**

The project follows a **lightweight MVVM structure** with a pragmatic separation of concerns. It avoids overengineering in favor of speed and clarity, ideal for the scope of this test.

```jsx
TechnicalSMG/
├── Data/
│   ├── Models/               → `Post`, `Comment`
│   └── Repository/           → `APIRepository`, `APIRepositoryImpl`
│
├── UI/
│   ├── Common/               → Shared views: `CustomTextField`, `ToastView`, `ErrorView`
│   ├── Fonts/                → Custom BR Sonoma font files
│   ├── ViewModels/           → `PostViewModel`, `PostDetailsViewModel`, `NewPostViewModel`
│   └── Views/
│       ├── NewPost/          → `NewPostView`
│       ├── Post/             → `PostsListView`, `PostView`
│       └── PostDetails/      → `PostDetailsView`
│
├── Utils/                    → Font helpers: `Font+Extension`
├── Assets/                   → App icons and images
├── Info.plist
└── Localizable.strings       → Multi-language support (EN/FR)
```

## **Key Decisions**

- **SwiftUI First**: Given the project scope and SMG’s product-minded mission, I prioritized fast UI iterations with SwiftUI and its modern, declarative paradigm.
- **No Dependency Injection / Clean Arch Overhead**: For this test, I avoided heavy architectures like Clean or VIPER. Instead, I focused on readable, modular code. In a production app, I’d definitely favor scalable patterns and DI tools like Resolver or Factory.
- **Singleton Repository**: The APIRepositoryImpl is designed as a singleton to ensure a single source of truth across view models. This allows consistent API management without unnecessary instantiation.
- **Separation of Concerns**: Clear distinction between:
    - Data for business logic and API
    - UI/Common for reusable components and style
    - ViewModels for business-to-UI logic
    - Views organized by features

## **Localization**

The app uses a Localizable.strings file and supports both **English** and **French**

## **Testing**

- **Unit Tests** are included for core logic validation.

## **Fonts**

Custom BR Sonoma fonts are included and used through a convenient font extension. This helps ensure a consistent and modern aesthetic.

## **Screenshots**
