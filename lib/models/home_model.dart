

class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.formHome(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.formData(json['data']);
  }
}

class HomeDataModel {
  List<HomeBannersModel> banners = [];
  List<HomeProductsModel> products = [];

  HomeDataModel.formData(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(HomeBannersModel.formBanners(element));
    });
    json['products'].forEach((element) {
      products.add(HomeProductsModel.formProducts(element));
    });

  }
}

class HomeBannersModel {
  int? id;
  String? image;
  Null? category;
  Null? product;

  HomeBannersModel.formBanners(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

}


class HomeProductsModel {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  HomeProductsModel.formProducts(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
