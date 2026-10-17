import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/product_store.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_helpers.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'Muebles';
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final price = double.parse(_priceController.text.replaceAll(',', '.'));
    final categoryStyle = _styleForCategory(_category);
    ProductStore.instance.add(
      Product(
        name: _nameController.text.trim(),
        price: price,
        category: _category,
        description: _descriptionController.text.trim(),
        icon: categoryStyle.$1,
        accent: categoryStyle.$2,
        imageBytes: _imageBytes,
      ),
    );
    Navigator.pop(context, true);
  }

  (IconData, Color) _styleForCategory(String category) {
    return switch (category) {
      'Muebles' => (
        Icons.chair_alt_outlined,
        Theme.of(context).colorScheme.primary,
      ),
      'Tecnología' => (Icons.devices_other_outlined, const Color(0xFFFFC229)),
      'Accesorios' => (Icons.headphones_outlined, const Color(0xFFB941F5)),
      _ => (Icons.inventory_2_outlined, const Color(0xFF21B58E)),
    };
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image == null) return;
    final bytes = await image.readAsBytes();
    if (mounted) setState(() => _imageBytes = bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar producto',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 26),
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.muted),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _imageBytes == null
                                  ? Icons.photo_camera_outlined
                                  : Icons.change_circle_outlined,
                              size: 36,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _imageBytes == null
                                  ? 'Agregar imagen\n(opcional)'
                                  : 'Cambiar imagen',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EAEC),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: _imageBytes == null
                            ? const Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFF555B60),
                                size: 58,
                              )
                            : Image.memory(_imageBytes!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const _Label(text: 'Nombre del producto', required: true),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ej. Mesa de madera',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Ingresa el nombre del producto'
                  : null,
            ),
            const SizedBox(height: 18),
            const _Label(text: 'Precio (S/)', required: true),
            const SizedBox(height: 8),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixIcon: Icon(Icons.monetization_on_outlined),
              ),
              validator: (value) {
                final price = double.tryParse(
                  (value ?? '').replaceAll(',', '.'),
                );
                if (price == null || price <= 0) {
                  return 'Ingresa un precio válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            const _Label(text: 'Categoría'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.sell_outlined),
              ),
              items: const [
                DropdownMenuItem(value: 'Muebles', child: Text('Muebles')),
                DropdownMenuItem(
                  value: 'Tecnología',
                  child: Text('Tecnología'),
                ),
                DropdownMenuItem(
                  value: 'Accesorios',
                  child: Text('Accesorios'),
                ),
                DropdownMenuItem(value: 'Otros', child: Text('Otros')),
              ],
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 18),
            const _Label(text: 'Descripción (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe brevemente el producto',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Icon(Icons.description_outlined),
                ),
              ),
            ),
            const SizedBox(height: 22),
            OrangeButton(
              label: 'GUARDAR PRODUCTO',
              icon: Icons.save_rounded,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text, this.required = false});

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ]
            : null,
      ),
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }
}
