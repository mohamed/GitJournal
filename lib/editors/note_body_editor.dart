/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:gitjournal/l10n.dart';
import 'package:gitjournal/utils/rtl.dart';

class NoteBodyEditor extends StatelessWidget {
  final TextEditingController textController;
  final bool autofocus;
  final Function onChanged;

  const NoteBodyEditor({
    super.key,
    required this.textController,
    required this.autofocus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, _) {
        var theme = Theme.of(context);
        var direction = detectTextDirection(value.text);

        return TextField(
          autofocus: autofocus,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: textStyle(context),
          decoration: InputDecoration(
            hintText: context.loc.editorsCommonDefaultBodyHint,
            border: InputBorder.none,
            fillColor: theme.scaffoldBackgroundColor,
            hoverColor: theme.scaffoldBackgroundColor,
            contentPadding: const EdgeInsets.all(0.0),
            isDense: true,
          ),
          controller: textController,
          textCapitalization: TextCapitalization.sentences,
          scrollPadding: const EdgeInsets.all(0.0),
          onChanged: (_) => onChanged(),
          textDirection: direction,
          textAlign: TextAlign.start,
        );
      },
    );
  }

  static TextStyle textStyle(BuildContext context) {
    var theme = Theme.of(context);
    return theme.textTheme.titleMedium!;
  }
}
