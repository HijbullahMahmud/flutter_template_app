import 'package:ag_pos/features/products/data/models/product_page_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deserializes a paginated product response and maps entities', () {
    final model = ProductPageModel.fromJson(_productPageJson);
    final entity = model.toEntity();

    expect(model.products, hasLength(1));
    expect(model.products.single.price, 9.99);
    expect(entity.items.single.title, 'Test product');
    expect(entity.items.single.thumbnailUrl, 'https://example.com/image.png');
    expect(entity.total, 25);
    expect(entity.skip, 12);
    expect(entity.limit, 12);
  });
}

final Map<String, dynamic> _productPageJson = <String, dynamic>{
  'products': <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 1,
      'title': 'Test product',
      'description': 'Description',
      'category': 'test',
      'price': 9.99,
      'rating': 4.5,
      'thumbnail': 'https://example.com/image.png',
    },
  ],
  'total': 25,
  'skip': 12,
  'limit': 12,
};
