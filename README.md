Ozai Chatbot is a simple and modular Flutter mobile application featuring two AI-powered assistants:

🧠 Raouf AI – your sport planning assistant.
💼 L'Boudi AI – your business and management advisor.
The app uses the DeepSeek Chat API to generate intelligent and contextual responses in real-time.

✨ Features
Home screen with selector between two assistants
AI-based chat interface using DeepSeek
Clean Flutter UI with theming
FloatingActionButton demo with counter (for testing)
Modular structure and easy to extend

🔐 DeepSeek API Key Setup
The app uses the DeepSeek Chat API to generate messages.

You must add your API key in ChatService.dart here: 
headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer YOUR_DEEPSEEK_API_KEY', } 
➡️ Replace YOUR_DEEPSEEK_API_KEY with your real API key from https://deepseek.com. 
🛡️ Tip: For security, consider loading the key from an .env file or secure storage in production.
