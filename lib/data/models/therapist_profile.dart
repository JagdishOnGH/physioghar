class TherapistProfile {
  final String id;
  final String name;
  final String title;
  final String email;
  final String phone;
  final String clinicAddress;
  final String bio;
  final String avatarUrl;
  final double rating;
  final int totalPatientsCount;
  final int yearsExperience;
  final List<String> specializations;

  TherapistProfile({
    required this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.clinicAddress,
    required this.bio,
    required this.avatarUrl,
    required this.rating,
    required this.totalPatientsCount,
    required this.yearsExperience,
    required this.specializations,
  });

  TherapistProfile copyWith({
    String? id,
    String? name,
    String? title,
    String? email,
    String? phone,
    String? clinicAddress,
    String? bio,
    String? avatarUrl,
    double? rating,
    int? totalPatientsCount,
    int? yearsExperience,
    List<String>? specializations,
  }) {
    return TherapistProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rating: rating ?? this.rating,
      totalPatientsCount: totalPatientsCount ?? this.totalPatientsCount,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      specializations: specializations ?? this.specializations,
    );
  }
}
