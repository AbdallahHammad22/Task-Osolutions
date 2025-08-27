class Category {
  int? id;
  String? name;
  String? color;
  String? iconUrl;
  String? imageFilter;
  int? imageSeedOffset;
  String? createdAt;

  Category({
    this.id,
    this.name,
    this.color,
    this.iconUrl,
    this.imageFilter,
    this.imageSeedOffset,
    this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      iconUrl: json['icon_url'],
      imageFilter: json['image_filter'],
      imageSeedOffset: json['image_seed_offset'],
      createdAt: json['created_at'],
    );
  }
}
