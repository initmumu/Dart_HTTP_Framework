# Dattp

> Dart로 HTTP Web Server를 만드는 가장 쉬운 방법

Dart 언어로 작성되고 사용되는 가장 쉬운 웹 서버 프레임워크

<img src="https://github.com/initmumu/Dart_HTTP_Framework/assets/96606378/87aeb225-41c5-4886-a09d-e8d30ed7ce83" width="50%" height="50%"><br/>

```dart
// Hello, Dattp
import 'Dattp.dart';

void main() {
final Dattp app = Dattp();

    app.get('/', (req, res) {
      res.send("Hello, Dattp!");
    });

    app.listen(5500);

}

```

## 개발자 정보

**Developer Nickname** initmumu

**Github** [https://github.com/initmumu](https://github.com/initmumu)

**Organization** KyungHee University CSE

## 프로젝트 정보

**Development Start** 2023.09

**Language**

<img src="https://img.shields.io/badge/dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">

## 설치 방법

추후 pub.dev를 통해 패키지를 제공할 예정입니다.

현재는 git clone을 이용하여 프레임워크를 사용하는 방법만 가능합니다.

## 사용 예제

추후 문서를 작성할 예정입니다.

## 업데이트 내역

- 0.1.0
  - 라우터 등록 기능 구현
  - Request Body 파싱 기능 지원
  - Request QueryString 파싱 기능 지원
  - Request Pathvariable 기능 지원
  - Get, Post Method 지원
  - 여러 가지 응답 형태 지원
    - Text
    - Json
    - Binary Stream

## 기여 방법

1. (<https://github.com/initmumu/Dart_HTTP_Framework/fork>)을 포크합니다.
2. (`git checkout -b feature/fooBar`) 명령어로 새 브랜치를 만드세요.
3. (`git commit -am 'Add some fooBar'`) 명령어로 커밋하세요.
4. (`git push origin feature/fooBar`) 명령어로 브랜치에 푸시하세요.
5. 풀리퀘스트를 보내주세요.

<!-- Markdown link & img dfn's -->

```

```
