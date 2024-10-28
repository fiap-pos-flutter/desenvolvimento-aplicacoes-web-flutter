// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/core/file_validator.dart';

void main() {
  test('1 - Valida se o arquivo possui extensao .jpeg', () {
    final fileName = "image.jpeg";
    final isValid = FileValidator.isJpeg(fileName);
    expect(isValid, true);
  });

  test('2 - Valida se o arquivo possui extensao .jpeg', () {
    final fileName = "image.png";
    final isValid = FileValidator.isJpeg(fileName);
    expect(isValid, false);
  });

  test('Valida se o tamanho do arquivo nao excede 5 MB', () {
    final fileBytes = Uint8List(FileValidator.maxFileSize);
    final isValid = FileValidator.isFileSizeValid(fileBytes);
    expect(isValid, true);
  });

  test('Retorna false para arquvos maiores que 5 MB', () {
    final fileBytes = Uint8List(FileValidator.maxFileSize + 1);
    final isValid = FileValidator.isFileSizeValid(fileBytes);
    expect(isValid, false);
  });

  test('1 - Valida a funcao completa de validacao de arquivo', () {
    final fileBytes = Uint8List(FileValidator.maxFileSize + 1);
    final fileName = 'image.jpeg';

    final isValid = FileValidator.validateFile(fileBytes, fileName);
    expect(isValid, false);
  });

  test('2 - Valida a funcao completa de validacao de arquivo', () {
    final fileBytes = Uint8List(FileValidator.maxFileSize);
    final fileName = 'image.jpeg';

    final isValid = FileValidator.validateFile(fileBytes, fileName);
    expect(isValid, true);
  });
}
