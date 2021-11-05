

class SearchModel {
  bool? status;
  Data? data;

  SearchModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.formJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<DataProducts> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Data.formJson(Map<String, dynamic> json) {
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
        data.add(DataProducts.formJson(v));
      });
    }
  }
}

class DataProducts {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;

  DataProducts.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}





