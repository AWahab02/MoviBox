import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_tickets_task/user_interface/screens/tickets_pages/tickets_page.dart';

void main() {
  testWidgets('TicketsScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TicketsScreen(
          title: 'Movie Title',
          release: '2023-01-01',
        ),
      ),
    );

    expect(find.text('Movie Title'), findsOneWidget);
    expect(find.text('In Theaters 2023-01-01'), findsOneWidget);
  });
}
