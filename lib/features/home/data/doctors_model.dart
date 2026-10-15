class DoctorModel {
  final String name;
  final Specialization? specialization;
  final String reviews;
  final String availability;
  final String image;
  final String experience;

  DoctorModel({
    required this.name,
    required this.specialization,
    required this.reviews,
    required this.availability,
    required this.image,
    required this.experience,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'] ?? '',
      specialization: json['specialization'] != null
          ? Specialization.fromJson(json['specialization'])
          : null,
      reviews: json['reviews'] ?? '',
      availability: json['availability'] ?? '',
      image: json['image'] ?? '',
      experience: json['experience'] ?? '',
    );
  }


}

class Specialization {
  final int id;
  final String name;

  Specialization({required this.id, required this.name});

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}
