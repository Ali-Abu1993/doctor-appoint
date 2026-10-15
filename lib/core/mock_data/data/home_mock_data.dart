import 'package:doctor_appointment/features/home/data/doctors_model.dart';

abstract class HomeMockData {
static List<DoctorModel> mockHomeDoctor = [DoctorModel(
  name: "Dr. Alexander Bennett",
  specialization: Specialization(id: 1, name: "Cardiologist"),
  reviews: "4.9 (124 reviews)",
  availability: "Available Today",
  image: "assets/images_and_icons/doctor image.jpg",
  experience: "10+ Years Exp.",
),
DoctorModel(
name: "Dr. Sarah Jenkins",
specialization: Specialization(id: 2, name: "Dental"),
reviews: "4.9 (124 reviews)",
availability: "Available Today",
image: "assets/images_and_icons/female_doc_img.jpg",
experience: "10+ Years Exp.")
];
}