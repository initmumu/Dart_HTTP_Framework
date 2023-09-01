import 'Dattp.dart';
import 'dart:io';
import 'dart:typed_data';

final int PORT = 8080;

void main() {
  final app = Dattp();

  app.get('/pororo', (req, res) {
    var filePath = 'public/jpeg_test_image.jpg';
    var imageFile = File(filePath).readAsBytesSync();

    res.send(imageFile);
  });

  app.get('/', (req, res) {
    res.text("Main Page 입니다!");
  });

  app.listen(PORT, () {
    print("서버가 시작되었습니다.");
  });
}
