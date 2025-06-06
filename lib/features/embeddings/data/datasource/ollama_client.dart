import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/const/const.dart';
import '../datasource_interfaces/client.dart';
import '../dto/embeddings_dto.dart';

class EmbeddingRetrievalConst {
  // static const textEmbeddingModel = 'nomic-embed-text';
  static const textEmbeddingModel = 'bge-large';
}

class EmbeddingsClientOllama implements EmbeddingsDatasource {
  final String baseUrl;

  EmbeddingsClientOllama({this.baseUrl = Const.ollamaUrl});

  @override
  Future<EmbeddingsDto> generateEmbeddings(String text) async {
    final url = Uri.parse('$baseUrl/api/embed');

    final payload = {
      'model': EmbeddingRetrievalConst.textEmbeddingModel,
      'input': text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      return (jsonResponse['embeddings'][0] as List).cast<double>();
    } catch (e) {
      print('Failed to retrieve embeddings for a text file');
      return [];
    }
  }
}
