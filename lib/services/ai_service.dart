import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // Use your real key here
  final String apiKey = "AIzaSyArzLyJgz_8HL1OQEOTeqQHVnFjogyDG5E";

  Future<Map<String, dynamic>> generateUI(String prompt) async {
    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apiKey");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": """
You are a Flutter UI JSON generator. 
CRITICAL: Return ONLY the JSON object. Do not include markdown backticks (```) or the word 'json'.

ALLOWED TYPES: text, textField, button, row, column, container.
PROPERTIES: 
- For 'textField': use 'label'.
- For 'button': use 'text'.
- For 'text': use 'value'.
- Use 'children' for row/column and 'child' for container.

JSON Schema Example:
{
  "type": "column",
  "children": [
    { "type": "text", "value": "Login" },
    { "type": "textField", "label": "Email" },
    { "type": "button", "text": "Submit" }
  ]
}

Request: $prompt
"""
              }
            ]
          }
        ]
      }),

    );

    print("DEBUG: Status Code: ${response.statusCode}");
    print("RAW RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("API Error: ${response.body}");
    }

    final data = jsonDecode(response.body);

    // Defensive Check: Make sure the candidates list exists
    if (data["candidates"] == null || data["candidates"].isEmpty) {
      throw Exception("No candidates returned from Gemini");
    }

    String text =
    data["candidates"][0]["content"]["parts"][0]["text"] ?? "";

// Clean garbage
text = text.replaceAll("```json", "").replaceAll("```", "").trim();

// Extract JSON manually
int start = text.indexOf("{");
int end = text.lastIndexOf("}");

if (start != -1 && end != -1) {
  text = text.substring(start, end + 1);
}

print("CLEAN JSON: $text");

//return jsonDecode(text);
try {
  return jsonDecode(text);
} catch (e) {
  print("FAILED JSON: $text");

  return {
    "type": "text",
    "value": "Error generating UI"
  };
}
  }
}