import 'package:doctor_appointment/features/alldoctors/data/doctor_model.dart';

abstract class AllDoctorsMockData {
  static final List<Data> doctorsList = [
    Data(
      id: 1,
      name: "Dr. Alexander Bennett",
      email: "alexander.bennett@hospital.com",
      phone: "+20 100 123 4567",
      photo: "assets/images_and_icons/doctor image.jpg",
      gender: "male",
      address: "Downtown Heart Center, Cairo",
      description: "Senior consultant in Cardiology and Cardiovascular interventions.",
      degree: "10+ Years Exp.",
      specialization: Specialization(id: 1, name: "Cardiology"),
      city: City(id: 1, name: "Cairo"),
      appointPrice: 250,
      startTime: "09:00",
      endTime: "21:00",
    ),
    Data(
      id: 2,
      name: "Dr. Sarah Jenkins",
      email: "sarah.jenkins@clinic.com",
      phone: "+20 111 234 5678",
      photo: "assets/images_and_icons/female_doc_img.jpg",
      gender: "female",
      address: "Smile Dental Clinic, Giza",
      description: "Cosmetic dentistry and orthodontics specialist.",
      degree: "8+ Years Exp.",
      specialization: Specialization(id: 2, name: "Dental"),
      city: City(id: 2, name: "Giza"),
      appointPrice: 200,
      startTime: "10:00",
      endTime: "20:00",
    ),
    Data(
      id: 3,
      name: "Dr. Marcus Vance",
      email: "marcus.vance@medcare.com",
      phone: "+20 122 345 6789",
      photo: "assets/images_and_icons/stock-vector-a-faceless-male-doctor-avatar-with-a-stethoscope-in-a-flat-design-ideal-for-healthcare-medical-2644008685.jpg",
      gender: "male",
      address: "Al-Noor Health Center, Alexandria",
      description: "Internal Medicine and general health checkup specialist.",
      degree: "12+ Years Exp.",
      specialization: Specialization(id: 3, name: "General"),
      city: City(id: 3, name: "Alexandria"),
      appointPrice: 180,
      startTime: "08:30",
      endTime: "18:00",
    ),
    Data(
      id: 4,
      name: "Dr. Elena Rostova",
      email: "elena.rostova@care.com",
      phone: "+20 109 876 5432",
      photo: "assets/images_and_icons/stock-vector-a-faceless-female-doctor-avatar-with-a-stethoscope-in-a-flat-design-circular-frame-ideal-for-2644131371.jpg",
      gender: "female",
      address: "Endocrine & Diabetes Care, Heliopolis",
      description: "Specialized in Endocrinology, diabetes care and hormonal disorders.",
      degree: "9+ Years Exp.",
      specialization: Specialization(id: 4, name: "Endocrinology"),
      city: City(id: 1, name: "Cairo"),
      appointPrice: 300,
      startTime: "09:00",
      endTime: "19:30",
    ),
  ];

  static DoctorsModel getDoctorsResponse({List<Data>? filteredList}) {
    return DoctorsModel(
      status: true,
      code: 200,
      message: "Doctors retrieved successfully",
      data: filteredList ?? doctorsList,
    );
  }

  static DoctorsModel searchDoctors(String query) {
    final lower = query.toLowerCase().trim();
    if (lower.isEmpty) return getDoctorsResponse();
    final results = doctorsList.where((doc) {
      final matchName = doc.name?.toLowerCase().contains(lower) ?? false;
      final matchSpec = doc.specialization?.name?.toLowerCase().contains(lower) ?? false;
      return matchName || matchSpec;
    }).toList();
    return getDoctorsResponse(filteredList: results);
  }
}
