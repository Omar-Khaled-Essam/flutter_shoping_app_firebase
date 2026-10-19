import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return TextButton.icon(
      onPressed: () => onLocaleChanged(
        isArabic ? const Locale('en') : const Locale('ar'),
      ),
      icon: const Icon(Icons.language),
      label: Text(isArabic
          ? AppLocalizations.of(context)!.english
          : AppLocalizations.of(context)!.arabic),
    );
  }
}
