// ignore_for_file: constant_identifier_names

class ProductEntity {
    int id;
    String title;
    double price;
    String description;
    Category category;
    String image;
    Rating rating;

    ProductEntity({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

}

enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

class Rating {
    double rate;
    int count;

    Rating({
        required this.rate,
        required this.count,
    });

}
