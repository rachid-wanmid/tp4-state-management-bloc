import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatRepository {
  final String _apiKey = 'YOUR_API_KEY_HERE';
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].toString();
      } else {
        throw Exception('Erreur API OpenAI: \${response.statusCode} - \${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion : \$e');
    }
  }
}
