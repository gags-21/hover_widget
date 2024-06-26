import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hover_widget/hover_widget.dart';

void main() {
  group('HoverWidget', () {
    test('can be instantiated', () {
      expect(
        HoverWidget(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Hover Test'),
          ),
        ),
        isNotNull,
      );
    });
  });
}
