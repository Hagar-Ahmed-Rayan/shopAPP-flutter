class SearchModel
{
 late bool status;
  late Null message;
 late Data data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
 late dynamic currentPage;//int

 late List<Product> data=[];
 late String firstPageUrl;
  late dynamic from;//int
 late  dynamic lastPage;//int
  late String lastPageUrl;
 late  Null nextPageUrl;
  late String path;
 late  dynamic perPage;//int
 late  Null prevPageUrl;
 late dynamic to;//int
 late dynamic total;//int

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {

      json['data'].forEach((v) {
        data.add( Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Product {
 late int id;//int
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;//int
  late String image;
 late  String name;
  late String description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}