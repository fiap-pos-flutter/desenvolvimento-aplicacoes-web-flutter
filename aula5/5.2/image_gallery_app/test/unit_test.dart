// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/file_validator.dart';
import 'package:flutter/services.dart' show rootBundle;

//Just upload extension jpeg with 5 megabytes of limit

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verifica o nome da imagem', () {
    String imageName = 'image.png';
    expect(imageName.isNotEmpty, true);
  });

  test('Verifica se a extensao do arquivo e JPEG - 1', () async {
    const filename = 'example1.jpeg';

    var data = await rootBundle.load('assets/$filename');
    var fileBytes = data.buffer.asUint8List();

    expect(FileValidator.validateFile(fileBytes, filename), true);
  });

    test('Verifica se a extensao do arquivo e JPEG - 2', () async {
    const filename = 'example4.jpg';

    var data = await rootBundle.load('assets/$filename');
    var fileBytes = data.buffer.asUint8List();

    expect(FileValidator.validateFile(fileBytes, filename), true);
  });
}
