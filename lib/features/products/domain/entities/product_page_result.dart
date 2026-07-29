import 'package:ag_pos/features/products/domain/entities/product.dart';

class ProductPageResult {
  const ProductPageResult({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Product> items;
  final int total;
  final int skip;
  final int limit;
}
