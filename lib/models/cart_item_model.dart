class Product {
  String id;
  ProductDetails productDetails;
  int selectedQuantity;
  String selectedMeasurementType;
  String clientId;

  Product({
    required this.id,
    required this.productDetails,
    required this.selectedQuantity,
    required this.selectedMeasurementType,
    required this.clientId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      productDetails: ProductDetails.fromJson(json['productId'] ?? {}),
      selectedQuantity: json['selectedQuantity'] ?? 0,
      selectedMeasurementType: json['selectedMeasurementType'] ?? '',
      clientId: json['clientId'] ?? '',
    );
  }
}

class ProductDetails {
  String id;
  String title;
  String description;
  String currencyCode;
  String measurementType;
  int unitPrice;
  int unitMeasurementQuantity;
  String unitMeasurementType;
  int quantity;
  String quantityMeasurementUnit;
  int wholesaleUnitPrice;
  int wholesaleQuantity;
  String wholesaleUnitMeasurementType;
  int minimumWholesaleQuantity;
  String minimumWholesaleQuantityMeasurementType;
  int status;
  List<ProductImage> productImages;

  ProductDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.currencyCode,
    required this.measurementType,
    required this.unitPrice,
    required this.unitMeasurementQuantity,
    required this.unitMeasurementType,
    required this.quantity,
    required this.quantityMeasurementUnit,
    required this.wholesaleUnitPrice,
    required this.wholesaleQuantity,
    required this.wholesaleUnitMeasurementType,
    required this.minimumWholesaleQuantity,
    required this.minimumWholesaleQuantityMeasurementType,
    required this.status,
    required this.productImages,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> images = json['productImages'] ?? [];
    List<ProductImage> productImages =
        images.map((image) => ProductImage.fromJson(image)).toList();

    return ProductDetails(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      currencyCode: json['currenyCode'] ?? '',
      measurementType: json['measurementType'] ?? '',
      unitPrice: json['unitPrice'] ?? 0,
      unitMeasurementQuantity: json['unitMeasurementQuantity'] ?? 0,
      unitMeasurementType: json['unitMeasurementType'] ?? '',
      quantity: json['quantity'] ?? 0,
      quantityMeasurementUnit: json['quantityMeasurementUnit'] ?? '',
      wholesaleUnitPrice: json['wholesaleUnitPrice'] ?? 0,
      wholesaleQuantity: json['wholesaleQuantity'] ?? 0,
      wholesaleUnitMeasurementType: json['wholesaleUnitMeasurementType'] ?? '',
      minimumWholesaleQuantity: json['minimumWholesaleQuantity'] ?? 0,
      minimumWholesaleQuantityMeasurementType:
          json['minimumWholesaleQuantityMeasurementType'] ?? '',
      status: json['status'] ?? 0,
      productImages: productImages,
    );
  }
}

class ProductImage {
  String id;
  String productId;
  String imageUrl;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
