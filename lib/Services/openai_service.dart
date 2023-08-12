import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/secrets.dart';

class OpenAIService {
  Future<String> isArtPrompt(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
            }
          ],
        }),
      );
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('finally');
      }
      return 'AI';
    } catch (e) {
      print("error");
      return e.toString();
    }
  }

  Future<String> chatGPT(String Propmpt) async {
    return 'CHATGPT';
  }

  Future<String> dallE(String Propmpt) async {
    return 'DALL-E';
  }
}
