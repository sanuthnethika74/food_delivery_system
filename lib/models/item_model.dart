// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String id;
  final String title;
  final String description;
  final String currenyCode;
  final int unitPrice;
  final int unitMeasurementQuantity;
  final String unitMeasurementType;
  final int quantity;
  final String quantityMeasurementUnit;
  final int status;
  final List<ProductImages> productImages;

  ItemModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.currenyCode,
      required this.unitPrice,
      required this.unitMeasurementQuantity,
      required this.unitMeasurementType,
      required this.quantity,
      required this.quantityMeasurementUnit,
      required this.status,
      required this.productImages});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'currenyCode': currenyCode,
      'unitPrice': unitPrice,
      'unitMeasurementQuantity': unitMeasurementQuantity,
      'unitMeasurementType': unitMeasurementType,
      'quantity': quantity,
      'quantityMeasurementUnit': quantityMeasurementUnit,
      'status': status,
      'productImages': productImages.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      currenyCode: map['currenyCode'] as String,
      unitPrice: map['unitPrice'] as int,
      unitMeasurementQuantity: map['unitMeasurementQuantity'] as int,
      unitMeasurementType: map['unitMeasurementType'] as String,
      quantity: map['quantity'] as int,
      quantityMeasurementUnit: map['quantityMeasurementUnit'] as String,
      status: map['status'] as int,
      productImages: List<ProductImages>.from(
        (map['productImages']).map<ProductImages>(
          (x) => ProductImages.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ProductImages {
  final String id;
  final String productId;
  final String imageUrl;

  ProductImages({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'imageUrl': imageUrl,
    };
  }

  factory ProductImages.fromMap(Map<String, dynamic> map) {
    return ProductImages(
      id: map['_id'] as String,
      productId: map['productId'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImages.fromJson(String source) =>
      ProductImages.fromMap(json.decode(source) as Map<String, dynamic>);
}
