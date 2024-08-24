// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/file_validator.dart';

//Just upload extension jpeg with 5 megabytes of limit

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FileValidator', () {
    test('Valida se o arquivo possui extensão .jpeg', () {
      final fileName = 'imagem.jpeg';
      final isValid = FileValidator.isJpeg(fileName);
      expect(isValid, true);
    });

    test('Valida se o tamanho do arquivo não excede 5 MB', () {
      final fileBytes = Uint8List(FileValidator.maxFileSize);
      final isValid = FileValidator.isFileSizeValid(fileBytes);
      expect(isValid, true);
    });

    test('Retorna falso para arquivos maiores que 5 MB', () {
      final fileBytes = Uint8List(FileValidator.maxFileSize + 1);
      final isValid = FileValidator.isFileSizeValid(fileBytes);
      expect(isValid, false);
    });

    test('Valida a função completa de validação de arquivo', () {
      final fileBytes = Uint8List(FileValidator.maxFileSize);
      final fileName = 'imagem.jpeg';
      final isValid = FileValidator.validateFile(fileBytes, fileName);
      expect(isValid, true);
    });

    test('Retorna falso para uma extensão inválida', () {
      final fileBytes = Uint8List(FileValidator.maxFileSize);
      final fileName = 'imagem.png';
      final isValid = FileValidator.validateFile(fileBytes, fileName);
      expect(isValid, false);
    });
  });
}
