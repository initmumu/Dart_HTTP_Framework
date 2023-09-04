import 'Dattp.dart';
import 'dart:io';

final int PORT = 8080;

void main() {
  final app = Dattp();

  app.get('/file-test-jpeg', (req, res) {
    res.sendFile('public/jpeg_test_image.jpg');
  });

  app.get('/file-test-png', (req, res) {
    res.sendFile('public/png_test_image.png');
  });

  app.get('/error/xlsx', (req, res) {
    res.sendFile('public/xlsx_test_file.xlsx');
  });

  app.get('/success/xlsx', (req, res) {
    res.download('public/xlsx_test_file.xlsx');
  });

  app.get('/text', (req, res) {
    res.send("text");
  });

  app.get('/json', (req, res) {
    var resp = {"코리언": 10};
    res.send(resp);
  });

  app.listen(PORT, () {
    print("서버가 시작되었습니다.");
  });
}
