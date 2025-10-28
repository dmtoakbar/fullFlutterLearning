import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;

/// ✅ A reusable class for API calls using Isolate
class IsolateApiCaller {
  /// Main function to fetch API data
  Future<dynamic> fetch(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    final receivePort = ReceivePort();

    // Step 1: Spawn isolate and pass sendPort + data
    final isolate = await Isolate.spawn(
      _apiWorker,
      {
        'sendPort': receivePort.sendPort,
        'url': url,
        'params': params,
      },
    );

    // Step 2: Wait for result
    final result = await receivePort.first;

    // Step 3: Cleanup
    receivePort.close();
    isolate.kill(priority: Isolate.immediate);

    // Step 4: Return result
    return result;
  }

  /// --- Worker Function (runs in another isolate) ---
  static Future<void> _apiWorker(Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final String url = message['url'];
    final Map<String, dynamic>? params = message['params'];

    try {
      Uri uri;

      // Add query parameters if provided
      if (params != null && params.isNotEmpty) {
        uri = Uri.parse(url).replace(queryParameters: params);
      } else {
        uri = Uri.parse(url);
      }

      // Perform API request
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        sendPort.send({'status': 'success', 'data': data});
      } else {
        sendPort.send({
          'status': 'error',
          'message': 'HTTP ${response.statusCode}',
        });
      }
    } catch (e) {
      sendPort.send({
        'status': 'error',
        'message': e.toString(),
      });
    } finally {
      // Gracefully terminate the isolate
      Isolate.exit();
    }
  }
}




/*
⚡ Key Concepts Demonstrated
| Concept                 | Example                          |
| ----------------------- | -------------------------------- |
| Create isolate          | `Isolate.spawn(apiWorker, port)` |
| SendPort → ReceivePort  | Message passing                  |
| Call API inside isolate | `http.get()`                     |
| Send result back        | `mainSendPort.send(data)`        |
| Stop isolate gracefully | `Isolate.exit()`                 |
| Force kill isolate      | `isolate.kill()`                 |

*/