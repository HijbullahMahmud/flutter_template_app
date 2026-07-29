import 'package:ag_pos/features/products/data/models/product_model.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_page_model.freezed.dart';
part 'product_page_model.g.dart';

@freezed
abstract class ProductPageModel with _$ProductPageModel {
  const factory ProductPageModel({
    required List<ProductModel> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductPageModel;

  const ProductPageModel._();

  factory ProductPageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageModelFromJson(json);

  ProductPageResult toEntity() {
    return ProductPageResult(
      items: products
          .map((ProductModel product) => product.toEntity())
          .toList(growable: false),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}
