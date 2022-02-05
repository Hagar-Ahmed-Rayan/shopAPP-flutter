class FavoritesModel
{
  late bool status;
  late Null message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
   // if(json['data'] != null)
    //  data= Data.fromJson(json['data']);
   // else
   //   data=null as Data;
  // data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
    data =  Data.fromJson(json['data'] );
  }
}

class Data {
  late int currentPage;
  //late List<FavoritesData> data;
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late  String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int perPage;
  late Null prevPageUrl;
  late  int to;
  late int total;
  List<FavoritesData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
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

  //  if (json['data'] != null)
    // data = new List<FavoritesData>();
    // var data = <FavoritesData>[];           // Always the recommended way.
    // var bar = List.filled(1, 0); // Not filled with `null`s.
    // var baz = List<int>.empty();
    //data = <FavoritesData>[];
    json['data'].forEach((v) {
      data.add( FavoritesData.fromJson(v));
    });
  }

}


class FavoritesData {
  late int id;
  late  Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
   // (json['product'] != null ?  Product.fromJson(json['product']) : null)!;

    json['product'] = Product.fromJson(json['product']);




  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  // Product(
  //    {this.id,
  //    this.price,
  //   this.oldPrice,
  //   this.discount,
  //  this.image,
  //  this.name,
  //  this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }*/
}