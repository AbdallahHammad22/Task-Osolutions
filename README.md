# **Task Management App**

Welcome to the **Task Management App**, a modern Flutter application designed to streamline task organization with a sleek interface and robust functionality.  
This app supports both **English and Arabic with full RTL support**, offering a seamless experience for managing tasks, categories, and more.  

---

## **Features**

- **Task Management**: Create, edit, delete, and mark tasks as completed with an intuitive interface.  
- **Category-Based Filtering**: Organize tasks by categories with dynamic selection and display.  
- **Localization**: Full support for English and Arabic, including RTL for Arabic, powered by `flutter_localizations` and `intl`.  
- **Language Switcher**: Toggle between English and Arabic directly from the task list screen.  
- **Image Support**: Display task images using a custom `ImageWidget` that handles network images, SVGs, and assets with shimmer effects.  
- **Pull-to-Refresh**: Refresh task lists effortlessly with a smooth pull-to-refresh mechanism.  
- **State Management**: Manage app state efficiently using `provider` for reactive UI updates.  
- **API Integration**: Seamless integration with a Supabase backend via `dio` for task and category data.  
- **Custom UI Widgets**: Utilize reusable widgets (`ImageWidget`, `MainText`, `MainTextField`) for a consistent and professional UI.  

---

## **Technologies Used**

- **Flutter**: The core framework for building a cross-platform mobile application.  
- **Dart**: The programming language powering the app's logic and UI.  
- **Provider**: For state management, ensuring reactive and scalable UI updates.  
- **GetIt**: For dependency injection, managing services like `ApiService`.  
- **Dio**: For handling HTTP requests to the Supabase backend.  
- **CachedNetworkImage**: For efficient image loading with caching and error handling.  
- **Flutter SVG**: For rendering SVG assets in the app.  
- **Shimmer**: For creating smooth loading animations.  
- **Shared Preferences**: For persisting user language preferences.  
- **Flutter Localizations**: For supporting multilingual functionality with RTL for Arabic.  

---

## **UI Enhancements**

### **Task Detail Screen**
- Displays task details in a modern **Card** with subtle shadows and rounded corners.  
- Uses **ImageWidget** for task images, featuring shimmer effects during loading.  
- Employs **MainText** for consistent typography with RTL support.  
- Features a **FloatingActionButton** for editing tasks and a delete button in the AppBar.  
- Includes a **CheckboxListTile** for toggling task completion with SnackBar feedback.  

### **Task Form Screen**
- Clean form for adding/editing tasks, wrapped in a **Card** with elevation and rounded borders.  
- Uses **MainTextField** for title and description inputs with validation + RTL support.  
- **DropdownButtonFormField** for category and priority selection.  
- Includes a **Date Picker** for due dates with intuitive UI.  
- Styled **ElevatedButtons** for save and cancel actions.  

---

## **Project Structure**
- lib/
- core/ # Core utilities, services, configurations (ApiService, AppColors, localization)
- models/ # Data models (Task, Category).
- providers/ # State management with Provider (TaskProvider, CategoryProvider, TaskFormProvider).
- view/ # UI components: screens (TaskList, TaskDetail, TaskForm) + widgets (ImageWidget, MainText, MainTextField).
- l10n/ # Localization files (app_en.arb, app_ar.arb).
  
---

## **Setup Instructions**

### 1. Clone the Repository
git clone https://github.com/AbdallahHammad22/Task-Osolutions
  
---

## **Run the App**
- flutter pub get
- flutter run
  
---

## **Screenshots**
<img width="569" height="926" alt="image" src="https://github.com/user-attachments/assets/6f881dd0-0dd2-4d87-953b-64f0b81c35bc" />
<img width="511" height="900" alt="image" src="https://github.com/user-attachments/assets/2342b70e-162c-41b7-8255-45aeb27605a5" />
<img width="537" height="933" alt="image" src="https://github.com/user-attachments/assets/a58fbe3a-d1b2-456a-b9d9-a675079fd5e0" />
<img width="546" height="904" alt="image" src="https://github.com/user-attachments/assets/519e3858-1e5c-412a-9151-17d85dccd568" />
<img width="541" height="917" alt="image" src="https://github.com/user-attachments/assets/676bae6c-3c44-424f-832f-96b9d1b8e896" />
<img width="539" height="898" alt="image" src="https://github.com/user-attachments/assets/ad3214bf-c8c9-457b-802a-0601ffecbe2b" />




  
---

## **Contact**

📧 Email: abdallahhamad343@gmail.com

📱 WhatsApp: +201029576647


