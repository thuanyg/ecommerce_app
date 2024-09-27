List<Category> categories = [
  Category("Clothes", "assets/images/ic_clothes.png"),
  Category("Sneakers", "assets/images/ic_sneakers.png"),
  Category("Cosmetic", "assets/images/ic_cosmetics.png"),
  Category("Hoodies", "assets/images/ic_hoodies.png"),
  Category("Electronics", "assets/images/ic_gadget.png"),
  Category("Jewelery", "assets/images/ic_jewelry.png"),
  Category("Shoes", "assets/images/ic_shoes.png"),
  Category("Shorts", "assets/images/ic_shorts.png"),
];
class Category{
  String name;
  String image;

  Category(this.name, this.image);
}

String baseUrl = "https://ecommerce-api-tulp.onrender.com";

