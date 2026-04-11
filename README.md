#  AI-Powered Dynamic UI Generator (Flutter)

A Flutter application that dynamically generates UI at runtime using AI.

This project demonstrates a **GenUI-style system** where user prompts are converted into structured JSON using AI, and then rendered into real Flutter widgets dynamically.


##  Features

*  Input any UI request (e.g., "Create a login form")
*  Uses AI to generate UI structure in JSON format
*  Dynamically builds Flutter widgets from JSON
*  Real-time UI rendering
*  Handles invalid/missing AI data safely (null-safe builder)



##  How It Works

```text
User Input → AI API → JSON Config → Dynamic Builder → Flutter UI
```

### Flow:

1. User enters a prompt
2. AI converts it into structured JSON
3. App parses the JSON
4. Dynamic builder renders widgets recursively


##  Supported Components

Currently supported UI elements:

* Text
* TextField
* Button
* Column
* Row
* Container
  



---

##  Project Structure

```
lib/
│
├── services/
│   └── ai_service.dart        # Handles AI API calls
│
├── widgets/
│   └── dynamic_builder.dart  # Converts JSON → Flutter UI
│
└── main.dart                 # UI + state management
```



##  Tech Stack

* Flutter
* Dart
* HTTP package
* Google Gemini API (free tier)







##  Example Prompts

Try inputs like:

* `Create a login form`
* `Simple contact form with name and message`
* `Dashboard with buttons`
* `Welcome screen with text and button`



##  Limitations

* AI responses may sometimes return:

  * invalid JSON
  * incomplete UI structure
* Only basic widgets are supported



##  Future Improvements

* Multi-screen generation
* Navigation support
* Save/export generated UI



##  Purpose

This project focuses on:

* Understanding AI + UI integration
* Handling unpredictable API responses
* Building dynamic UI systems
* Moving beyond static app development



##  Note

This is an **experimental project inspired by GenUI concepts**.
The goal is to explore how AI can assist in generating application interfaces dynamically.



##  Author

Built as a learning and exploration project in Flutter + AI integration.

