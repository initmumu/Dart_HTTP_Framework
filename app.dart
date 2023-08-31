import 'Dattp.dart';

final int PORT = 8080;

void main() {
  final app = Dattp();

  app.get('/', (req, res) {
    res.text("Main Page 입니다!");
  });

  app.listen(PORT, () => print("서버가 시작되었습니다."));
}
