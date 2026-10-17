import 'package:flutter/material.dart';

import '../data/product_store.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_helpers.dart';
import 'product_form_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _query = '';

  List<Product> get _filteredProducts {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return ProductStore.instance.products;
    return ProductStore.instance.products
        .where(
          (product) =>
              product.name.toLowerCase().contains(query) ||
              product.category.toLowerCase().contains(query),
        )
        .toList();
  }

  Future<void> _openForm() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const ProductFormScreen()),
    );
    if (saved == true && mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto registrado correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    return Scaffold(
      body: PagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Productos',
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Lista de productos registrados',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 58,
                  height: 58,
                  child: FilledButton(
                    onPressed: _openForm,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Icon(Icons.add, size: 34),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: Icon(Icons.search, size: 28),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: products.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron productos',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    )
                  : ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          _ProductCard(product: products[index]),
                    ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Total de productos: ${ProductStore.instance.products.length}',
                style: const TextStyle(color: AppColors.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: product.accent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Container(
                width: 76,
                height: 68,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9EBED),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  product.icon,
                  size: 43,
                  color: const Color(0xFF30353A),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'S/ ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.orange,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }
}
