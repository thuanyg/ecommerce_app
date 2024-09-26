import 'dart:convert';

class JwtUtils {
  static String decodeBase64(String str) {
    // Add padding if necessary
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Invalid base64 string');
    }
    return utf8.decode(base64Url.decode(output));
  }

  static Map<String, dynamic> getPayload(String token) {
    // Split the token into parts
    final parts = token.split('.');

    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    // Decode payload (the second part)
    String payload = decodeBase64(parts[1]);

    print('Decoded Payload: $payload');

    // You can then convert the payload to a map for easier access
    final payloadMap = json.decode(payload);
    return payloadMap;
  }
}
