import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_app/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de integração: Seleção e Upload de Imagem',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Simula o clique no botão de selecionar imagem
    final selectButton = find.text('Selecionar Imagem');
    expect(selectButton, findsOneWidget);
    await tester.tap(selectButton);
    await tester.pumpAndSettle();

    // Simula a seleção de um arquivo (a ser simulado com uma função mock)
    // Nota: Aqui é onde normalmente se injetaria um arquivo de teste.

    // Verifica se a imagem foi carregada e está visível na tela
    expect(find.byType(Image), findsOneWidget);

    // Simula o clique no botão de upload
    final uploadButton = find.text('Fazer Upload');
    await tester.tap(uploadButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verifica se o texto de sucesso aparece na tela
    expect(find.text('Imagem enviada com sucesso!'), findsOneWidget);
  });
}
