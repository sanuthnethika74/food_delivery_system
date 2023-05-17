// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CheckoutResponse {
  String cardNumber;
  String csv;
  String expiry;
  String firstName;
  String lastName;
  String measurementType;
  String productId;
  String quantity;
  String totalAmount;

  CheckoutResponse({
    required this.cardNumber,
    required this.csv,
    required this.expiry,
    required this.firstName,
    required this.lastName,
    required this.measurementType,
    required this.productId,
    required this.quantity,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'csv': csv,
      'expiry': expiry,
      'firstName': firstName,
      'lastName': lastName,
      'measurementType': measurementType,
      'productId': productId,
      'quantity': quantity,
      'totalAmount': totalAmount,
    };
  }

  factory CheckoutResponse.fromMap(Map<String, dynamic> map) {
    return CheckoutResponse(
      cardNumber: map['cardNumber'] as String,
      csv: map['csv'] as String,
      expiry: map['expiry'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      measurementType: map['measurementType'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as String,
      totalAmount: map['totalAmount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckoutResponse.fromJson(String source) =>
      CheckoutResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
