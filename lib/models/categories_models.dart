class CategoriesModel {
  bool? status;
  String? message;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CategoriesData.formJson(json['data']);
  }
}

class CategoriesData {
  int? currentPage;
  List<CategoriesDataModel> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  CategoriesData.formJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_pageUrl'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_pageUrl'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    json['data'].forEach((element) {
      data.add(CategoriesDataModel.formJson(element));
    });
  }
}
class CategoriesDataModel {
  int? id;
  String? name;
  String? image;

  CategoriesDataModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}
