
# Daily-Zen

- Cultivating Happiness.

## Features

- The app is a list of cards displayed for a given day. The user can navigate to previous days using the previous/next buttons. The user can only go back upto 7 days. The previous button is disabled once The content for displaying each card is available in the API from the Coding instructions above. The API has a get parameter "?date=" that can be used to fetch results for a given date.

- Each card has a CTA. Share and send actions opens up the "Share screen". Read Full Post CTA opens up the post url in an external browser. Bookmark CTA or Add Affirmation CTA for this assignment does nothing.

- Share screen has an option to Copy text to Clipboard. The screen has a list of options of apps the user can use to share. It's a customised order list With Whatsapp, Instagram, Facebook at the top of the list. The More button in the list opens up the default app selector of the iOS system. When the user selects an option to share, the Image along with the text caption is shared. Check API structure (6) for the text to share.

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## App Architecture

Architecture used `MVVM`

- **Model**: Represents the data and business logic of your app.
- **View**: Represents the user interface (UI) elements displayed to the user.
- **ViewModel**: Acts as an intermediary between the Model and View, handling data processing and presentation logic. It exposes data bindings that the View observes and updates accordingly.

More
- **Utilities**: Contains reusable utility classes, extensions, helper functions, or other miscellaneous code that doesn't belong to a specific feature or component of the app. 
- **Services**: Contains classes or components responsible for handling specific tasks or functionality that can be shared across different parts of the app, like Networking. 
- **Resources**: Used to organize various types of non-code assets, such as images, audio files, video files, fonts, and configuration files.
- **Extensions**: Used to create extension of inbuilt classes to extend their functionalities.

## Project Structure
    .
    ├── Daily Zen  
    │   ├── Daily_ZenApp.swift  
    │   ├── Features  
    │   │   ├── CustomShareView  
    │   │   │   └── View  
    │   │   │       └── CustomShareView.swift  
    │   │   ├── DailyZen  
    │   │   │   ├── Model  
    │   │   │   │   └── DailyZenDetail.swift  
    │   │   │   ├── View  
    │   │   │   │   ├── DailyZenCardView.swift  
    │   │   │   │   ├── DailyZenView.swift  
    │   │   │   │   └── DashboardCell.swift  
    │   │   │   └── ViewModel  
    │   │   │       └── DailyZenViewModel.swift  
    │   │   ├── RemoteImage  
    │   │   │   └── View  
    │   │   │       └── RemoteImage.swift  
    │   │   └── RootNavigation  
    │   │       └── View  
    │   │           └── RootNavigation.swift  
    │   ├── Services  
    │   │   ├── EnvironmentData.swift  
    │   │   ├── NetworkService.swift  
    │   │   └── PersistenceStore.swift  
    │   ├── Preview Content  
    │   ├── Resources  
    │   │   ├── Inter-Medium.ttf  
    │   │   ├── Inter-SemiBold.ttf  
    │   │   └── Inter.ttf  
    │   ├── Extensions  
    │   │   └── Color+Extension.swift  
    │   ├── Assets.xcassets  
    │   ├── Daily_Zen.xcdatamodeld  
    │   └── Utilities  
    │       ├── CustomFont.swift  
    │       ├── Theme.swift  
    │       └── TopBottomBorder.swift  
    ├── Daily Zen.xcodeproj  
    ├── Daily ZenTests  
    │   └── Daily_ZenTests.swift  
    ├── Daily-Zen-Info.plist  
    └── README.md  

## Installation

1. Clone the repository.
2. Open `Daily Zen` in Xcode.
3. Choose the target you want to run.
4. Build & run!
