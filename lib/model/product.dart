enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  const Product(
      {this.category, this.id, this.isFeatured, this.name, this.price});

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  String get assetName => '$id-0.jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() => '$name (id=$id)';
}
