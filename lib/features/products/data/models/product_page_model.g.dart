// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductPageModel _$ProductPageModelFromJson(Map<String, dynamic> json) =>
    _ProductPageModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ProductPageModelToJson(_ProductPageModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
