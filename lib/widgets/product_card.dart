import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onAdd,
  });

  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: Color(0xFFE8E5FF),
                child: Icon(Icons.image_not_supported_outlined, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 4, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(price,
                      style: const TextStyle(
                          color: Color(0xFF5B4BDB),
                          fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  tooltip: strings.addToCart,
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_shopping_cart),
                  color: const Color(0xFF5B4BDB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
