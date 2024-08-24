import 'dart:typed_data';

class FileValidator {
  // Tamanho máximo permitido em bytes (5 MB)
  static const int maxFileSize = 5 * 1024 * 1024; // 5 MB em bytes
  static const String validExtension = ".jpeg";

  /// Valida se o arquivo atende aos requisitos de extensão e tamanho
  static bool validateFile(Uint8List fileBytes, String fileName) {
    // Verificar se a extensão do arquivo é ".jpeg"
    if (!_isJpeg(fileName)) {
      print("Extensão inválida. Apenas arquivos .jpeg são permitidos.");
      return false;
    }

    // Verificar se o tamanho do arquivo é menor ou igual a 5 MB
    if (!_isFileSizeValid(fileBytes)) {
      print("O tamanho do arquivo excede 5 MB.");
      return false;
    }

    return true;
  }

  /// Verifica se o arquivo possui a extensão ".jpeg"
  static bool _isJpeg(String fileName) {
    return fileName.toLowerCase().endsWith(validExtension);
  }

  /// Verifica se o tamanho do arquivo é menor ou igual ao limite permitido
  static bool _isFileSizeValid(Uint8List fileBytes) {
    return fileBytes.length <= maxFileSize;
  }
}