List<Category> categories = [
  Category("Shoes", "assets/images/ic_shoes.png"),
  Category("Hoodies", "assets/images/ic_hoodies.png"),
  Category("Shorts", "assets/images/ic_shorts.png"),
  Category("Electronics", "assets/images/ic_shorts.png"),
  Category("Jewelery", "assets/images/ic_shorts.png"),
  Category("Men", "assets/images/ic_shorts.png"),
  Category("Women", "assets/images/ic_shorts.png"),
];
class Category{
  String name;
  String image;

  Category(this.name, this.image);
}