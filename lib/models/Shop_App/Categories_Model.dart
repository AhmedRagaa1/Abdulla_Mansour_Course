class CategoriesModel
{
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesDataModel.fromjson(json['data']);
  }

}

class CategoriesDataModel
{
   int currentpage;
  List<DataModel> data = [];

  CategoriesDataModel.fromjson(Map<String, dynamic> json)
  {
    currentpage = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(DataModel.fromjson((element)));
    });
  }
}
class DataModel
{
  int id;
  String name;
  String image;

  DataModel.fromjson(Map<String, dynamic> json)
  {

    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}