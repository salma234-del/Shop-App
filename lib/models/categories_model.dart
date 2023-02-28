class CategoriesModel {
  bool status;
  CategoriesData data;
  CategoriesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = CategoriesData.fromJson(json['data']);
}

class CategoriesData {
  int currentPage;
  List<DataModel> data = [];
  CategoriesData.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        data =
            List.from(json['data']).map((e) => DataModel.fromJson(e)).toList();
}

class DataModel {
  int id;
  String image;
  String name;
  DataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        name = json['name'];
}
