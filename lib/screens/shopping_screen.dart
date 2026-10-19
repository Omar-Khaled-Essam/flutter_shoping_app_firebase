import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'user_form_screen.dart';

import '../l10n/app_localizations.dart';
import '../widgets/language_button.dart';
import '../widgets/offer_tile.dart';
import '../widgets/product_card.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.82);
  int _cartCount = 0;

  final List<String> _productImages = const [
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
    'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addToCart() {
    setState(() => _cartCount++);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.itemAdded)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = screenWidth >= 900 ? 4 : 2;
    final horizontalPadding = screenWidth >= 900 ? 32.0 : 16.0;

    final products = [
      (
        strings.productShoes,
        'EGP 1,250',
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'
      ),
      (
        strings.productWatch,
        'EGP 2,100',
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600'
      ),
      (
        strings.productBag,
        'EGP 950',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600'
      ),
      (
        strings.productHeadphones,
        'EGP 1,600',
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600'
      ),
    ];

    final offers = [
      (
        strings.offerOneTitle,
        strings.offerOneDescription,
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=500'
      ),
      (
        strings.offerTwoTitle,
        strings.offerTwoDescription,
        'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=500'
      ),
      (
        strings.offerThreeTitle,
        strings.offerThreeDescription,
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'
      ),
      (
        strings.offerFourTitle,
        strings.offerFourDescription,
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500'
      ),
      (
        strings.offerFiveTitle,
        strings.offerFiveDescription,
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.shoppingTitle),
        actions: [
          LanguageButton(onLocaleChanged: widget.onLocaleChanged),
          IconButton(
            tooltip: 'Save user information',
            icon: const Icon(Icons.assignment_ind_outlined),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (_) => const UserFormScreen())),
          ),
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                    builder: (_) =>
                        LoginScreen(onLocaleChanged: widget.onLocaleChanged)),
                (route) => false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Center(
              child: Badge(
                label: Text('$_cartCount'),
                isLabelVisible: _cartCount > 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(title: strings.ourProducts),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _productImages.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          _productImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const ColoredBox(
                            color: Color(0xFFE8E5FF),
                            child: Icon(Icons.shopping_bag_outlined, size: 56),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: strings.featuredProducts),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: screenWidth >= 600 ? 0.95 : 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      name: product.$1,
                      price: product.$2,
                      imageUrl: product.$3,
                      onAdd: _addToCart,
                    );
                  },
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: strings.hotOffers),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return OfferTile(
                      title: offer.$1,
                      description: offer.$2,
                      imageUrl: offer.$3,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
