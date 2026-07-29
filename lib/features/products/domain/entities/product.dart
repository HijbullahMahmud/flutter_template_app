class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.thumbnailUrl,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String thumbnailUrl;
}
