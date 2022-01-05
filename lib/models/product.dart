class Product{

  int id;
  String name;
  String slug;
  String description;
  String price;
  DateTime createdAt;
  DateTime updatedAt;


  Product({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      price: json["price"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}