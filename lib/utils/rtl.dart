/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:flutter/widgets.dart';

/// Returns [TextDirection.rtl] if the first strong-directional character in
/// [text] belongs to a known RTL script (Arabic, Hebrew, Syriac, Thaana,
/// NKo, etc.); otherwise returns [TextDirection.ltr].
///
/// The scan stops at the first character whose Unicode block unambiguously
/// indicates a writing direction, so the cost is O(1) in practice for most
/// real-world content.
TextDirection detectTextDirection(String text) {
  for (final rune in text.runes) {
    // Arabic (U+0600–U+06FF)
    if (rune >= 0x0600 && rune <= 0x06FF) return TextDirection.rtl;
    // Hebrew (U+0590–U+05FF)
    if (rune >= 0x0590 && rune <= 0x05FF) return TextDirection.rtl;
    // Syriac (U+0700–U+074F)
    if (rune >= 0x0700 && rune <= 0x074F) return TextDirection.rtl;
    // Arabic Supplement (U+0750–U+077F)
    if (rune >= 0x0750 && rune <= 0x077F) return TextDirection.rtl;
    // Thaana (U+0780–U+07BF)
    if (rune >= 0x0780 && rune <= 0x07BF) return TextDirection.rtl;
    // NKo (U+07C0–U+07FF)
    if (rune >= 0x07C0 && rune <= 0x07FF) return TextDirection.rtl;
    // Arabic Extended-A (U+08A0–U+08FF)
    if (rune >= 0x08A0 && rune <= 0x08FF) return TextDirection.rtl;
    // Arabic Presentation Forms-A (U+FB50–U+FDFF)
    if (rune >= 0xFB50 && rune <= 0xFDFF) return TextDirection.rtl;
    // Arabic Presentation Forms-B (U+FE70–U+FEFF)
    if (rune >= 0xFE70 && rune <= 0xFEFF) return TextDirection.rtl;

    // Strong LTR: Basic Latin letters (skip digits, punctuation, whitespace)
    if ((rune >= 0x0041 && rune <= 0x005A) || // A–Z
        (rune >= 0x0061 && rune <= 0x007A) || // a–z
        (rune >= 0x00C0 && rune <= 0x02B8)) {
      // Latin Extended
      return TextDirection.ltr;
    }
  }
  return TextDirection.ltr;
}

/// Returns `true` if the first strong-directional character in [text] is RTL.
bool isRtlText(String text) =>
    detectTextDirection(text) == TextDirection.rtl;
