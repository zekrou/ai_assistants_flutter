import 'dart:convert';

import 'package:http/http.dart';

class ChatService{
  askDeepSeek(List<Map<String,Object>> chatHistory) async {

    final response = await post(
      Uri.parse("https://api.deepseek.com/chat/completions"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer API KEY DEEP SEEK',
      },
      body: jsonEncode({
        "model": "deepseek-chat",
        "messages": chatHistory,
      }),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonData['choices'][0]['message']['content'];
    } else {
      return response.body;
    }
    // print(response.body);
  }
}