import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class CloudinarySevice {
  Future<String> uploadToCloudinary(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/ddd16s54h/image/upload'),
    );

    request.fields['upload_preset'] = 'locafy_business';

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    final data = jsonDecode(responseData);

    return data['secure_url'];
  }
}
