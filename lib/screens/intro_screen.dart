import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/app_localizations.dart';
import '../widgets/language_button.dart';
import 'signup_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.firstProjectTitle),
        actions: [LanguageButton(onLocaleChanged: onLocaleChanged)],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (screenSize.width >= 520)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LocalImage(),
                      const SizedBox(width: 20),
                      const _NetworkImage(),
                    ],
                  )
                else
                  const Column(
                    children: [
                      _LocalImage(),
                      SizedBox(height: 16),
                      _NetworkImage(),
                    ],
                  ),
                const SizedBox(height: 28),
                Text(
                  strings.twoImagesDisplayed,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.suwannaphum(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5B4BDB),
                  ),
                ),
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder<void>(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, animation, secondaryAnimation) =>
                            SignupScreen(onLocaleChanged: onLocaleChanged),
                        transitionsBuilder: (_, animation, secondaryAnimation,
                                child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: Text(strings.startShopping),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocalImage extends StatelessWidget {
  const _LocalImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        'assets/images/local_shopping.png',
        width: 220,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600',
        width: 220,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 220,
          height: 180,
          color: const Color(0xFFE8E5FF),
          child: const Icon(Icons.storefront, size: 64),
        ),
      ),
    );
  }
}
