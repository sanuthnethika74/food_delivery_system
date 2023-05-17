class ShippedOrderModel {
  final String id;
  final String clientId;
  final String sellerId;
  final Product productId;
  final int quantity;
  final String measurementType;
  final String currencyCode;
  final String totalAmount;
  final String orderStatus;
  final DateTime date;
  final int v;
  final DeliveryPerson deliveryPersonId;

  ShippedOrderModel({
    required this.id,
    required this.clientId,
    required this.sellerId,
    required this.productId,
    required this.quantity,
    required this.measurementType,
    required this.currencyCode,
    required this.totalAmount,
    required this.orderStatus,
    required this.date,
    required this.v,
    required this.deliveryPersonId,
  });

  factory ShippedOrderModel.fromJson(Map<String, dynamic> json) {
    return ShippedOrderModel(
      id: json['_id'],
      clientId: json['clientId'],
      sellerId: json['sellerId'],
      productId: Product.fromJson(json['productId']),
      quantity: json['quantity'],
      measurementType: json['measurementType'],
      currencyCode: json['currenyCode'],
      totalAmount: json['totalAmount'],
      orderStatus: json['orderStatus'],
      date: DateTime.parse(json['date']),
      v: json['__v'],
      deliveryPersonId: DeliveryPerson.fromJson(json['deliveryPersonId']),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final List<ProductImage> productImages;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.productImages,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      productImages: (json['productImages'] as List<dynamic>)
          .map((image) => ProductImage.fromJson(image))
          .toList(),
    );
  }
}

class ProductImage {
  final String id;
  final String productId;
  final String imageUrl;
  final int v;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.v,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['_id'],
      productId: json['productId'],
      imageUrl: json['imageUrl'],
      v: json['__v'],
    );
  }
}

class DeliveryPerson {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;

  DeliveryPerson({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
  });

  factory DeliveryPerson.fromJson(Map<String, dynamic> json) {
    return DeliveryPerson(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNo: json['mobileNo'],
    );
  }
}
