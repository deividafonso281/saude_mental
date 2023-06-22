import 'package:flutter/material.dart';
import 'package:frontend/screens/search/psychologists_list.dart';
import 'package:test/test.dart';

void main() {
  group('CardListState', () {
    test('checkIsEmpty should return the correct message', () {
      final cardListState = CardListState();

      // Test case 1: Empty cardList
      final emptyCardList = <Widget>[];
      expect(cardListState.checkIsEmpty(emptyCardList), cardListState.checkEmptyMessage);

      // Test case 2: Non-empty cardList
      final nonEmptyCardList = <Widget>[Container(), Container()];
      expect(cardListState.checkIsEmpty(nonEmptyCardList), isNull);
    });
  });
}
