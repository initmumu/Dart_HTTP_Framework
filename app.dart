import 'Dattp.dart';
import 'dart:io';

final int PORT = 8080;

void main() {
  final app = Dattp();

  app.post('/post-test', (req, res) {
    res.text("post test");
  });

  app.get('/pororo', (req, res) {
    var filePath = 'public/jpeg_test_image.jpg';
    var imageFile = File(filePath).readAsBytesSync();

    res.send(imageFile);
  });

  app.get('/param_test/:num/nested', (req, res) {
    res.text(req.params['num']);
  });

  app.get('/', (req, res) {
    res.text("Main Page 입니다!");
  });

  app.listen(PORT, () {
    print("서버가 시작되었습니다.");
  });
}
