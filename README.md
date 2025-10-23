# 🧠 Pokedex iOS application

## 🧰 Tech Stack
- **Swift**, **SwiftUI**, **Kingfisher**, **Async/Await**, **PokéAPI**, **Xcode 16.2**

## 🚀 Functionalities:
- Load Pokemons from an API endpoint and display images on application.
- Contains image caching to prevent re-accessing images per load.
- Allows new image fetches when last row of images are loaded for the current fetch.
- Uses SwiftUI, async/await, Model View ViewModel (MVVM), @Observable and @State properties.

## Choice of framework explanation:
- Ensures all UI facing data logic in the view model are running on the MainActor to enable reactive UI states.
- Uses async/await to fetch API with rate limitation.
- To sure async/await function runs on view load, it's wrapped in a task which will get deallocated when view is gone.
- UI improvements include a change of color on current selected pokemon, flexible image frames for adaptive columnes, and built in navigation stack and ProgressView() with SwiftUI to provide additional user friendly interface.
- To ensure MVVM structure, model only contains necessary data definitions, view model contains business logic, view provides UI components and any logic to showcase different views. @ViewBuilder is used to allow dynamic view building.


<img width="300" height="650" alt="Simulator Screenshot - iPhone 16 - 2025-10-21 at 18 11 43" src="https://github.com/user-attachments/assets/7af380de-02a7-4a90-ba2c-1046dc05cafe" /> <img width="300" height="650" alt="Simulator Screenshot - iPhone 16 - 2025-10-21 at 19 04 47" src="https://github.com/user-attachments/assets/0334b9b5-99c1-4bcc-b2ee-c6b18accc937" />

Video Demo:

https://github.com/user-attachments/assets/a1bf557c-7944-4ed4-95b8-dc82c9fe794c


## 🏗️ Installation
1. Clone the repo  
   ```bash
   git clone https://github.com/Alaina-gl/Pokedex_app.git

2. Open in XCode
3. And enjoy :)



