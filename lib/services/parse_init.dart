import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseInit {
  static Future<void> init() async {
    const keyApplicationId = 'OXKdSzw9ow7BwO9oJnRt7eIJr6NrAOHBF6eJgazn';
    const keyClientKey = 'kIIA4JSHVufW1yjuckykz4IRFmdN1QBIG7Co3Io6';
    const keyParseServerUrl = 'https://parseapi.back4app.com/';

    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
    );
  }
}
