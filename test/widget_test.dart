import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTY4OTI2MjUzOSwiZXhwIjozMzc4NTMyMjc4fQ.NoagX9b9oJ3LX15li9CZ89F-4GfveVbmJPfarQUTpvU';

  Uri url = Uri.parse('https://apipps.kolektifhost.com/suratmasuk');
  var response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});
  var tempData = json.decode(response.body);
  print(tempData);
}
