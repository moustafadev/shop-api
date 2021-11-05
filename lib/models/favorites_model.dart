class FavoritesModel {
  bool? status;
  String? message;
  FavoritesData? data;

  FavoritesModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoritesData.formJson(json['data']) : null;
  }
}

class FavoritesData {
  int? currentPage;
  List<Data> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FavoritesData.formJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_pageUrl'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_pageUrl'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.formJson(v));
      });
    }
  }
}

class Data {
  int? id;
  ProductModel? product;

  Data.formJson(Map<String, dynamic> json) {
    id = json['id'];
    product =json['product'] != null ? ProductModel.formProducts(json['product']) : null;
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductModel.formProducts(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
