/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gitjournal/utils/rtl.dart';
import '../lib.dart';

void main() {
  setUpAll(gjSetupAllTests);

  group('detectTextDirection', () {
    test('Arabic text is RTL', () {
      expect(detectTextDirection('مرحبا'), TextDirection.rtl);
    });

    test('Hebrew text is RTL', () {
      expect(detectTextDirection('שלום'), TextDirection.rtl);
    });

    test('Latin/English text is LTR', () {
      expect(detectTextDirection('Hello world'), TextDirection.ltr);
    });

    test('Empty string defaults to LTR', () {
      expect(detectTextDirection(''), TextDirection.ltr);
    });

    test('Leading whitespace before RTL character is RTL', () {
      expect(detectTextDirection('   مرحبا'), TextDirection.rtl);
    });

    test('Leading punctuation before RTL character is RTL', () {
      expect(detectTextDirection('! مرحبا'), TextDirection.rtl);
    });

    test('Leading whitespace before Latin character is LTR', () {
      expect(detectTextDirection('   Hello'), TextDirection.ltr);
    });

    test('Mixed string starting with RTL is RTL', () {
      expect(detectTextDirection('مرحبا Hello'), TextDirection.rtl);
    });

    test('Mixed string starting with LTR is LTR', () {
      expect(detectTextDirection('Hello مرحبا'), TextDirection.ltr);
    });

    test('Greek text (non-Latin non-RTL) defaults to LTR', () {
      expect(detectTextDirection('Γειά σου'), TextDirection.ltr);
    });

    test('CJK text defaults to LTR', () {
      expect(detectTextDirection('你好世界'), TextDirection.ltr);
    });

    test('Digits-only defaults to LTR', () {
      expect(detectTextDirection('12345'), TextDirection.ltr);
    });
  });

  group('isRtlText', () {
    test('Arabic text returns true', () {
      expect(isRtlText('مرحبا'), isTrue);
    });

    test('Hebrew text returns true', () {
      expect(isRtlText('שלום'), isTrue);
    });

    test('English text returns false', () {
      expect(isRtlText('Hello'), isFalse);
    });

    test('Empty string returns false', () {
      expect(isRtlText(''), isFalse);
    });
  });
}
