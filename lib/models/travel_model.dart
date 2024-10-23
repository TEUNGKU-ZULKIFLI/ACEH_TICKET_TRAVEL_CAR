class Travel {
  final String image;
  final String title;
  final String price;
  final String description;
  final double rating;
  final List<String> reviews;
  final List<String> facilities;
  final List<String> paymentOptions;
  final String departureTime;
  final String arrivalTime;
  final List<String> images;

  Travel({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.facilities,
    required this.paymentOptions,
    required this.departureTime,
    required this.arrivalTime,
    required this.images,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      image: json['image'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      reviews: List<String>.from(json['reviews']),
      facilities: List<String>.from(json['facilities']),
      paymentOptions: List<String>.from(json['payment_options']),
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      images: List<String>.from(json['images']),
    );
  }
}