class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String avatar;
  final String primaryCondition;
  final int totalSessions;
  final DateTime lastVisit;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.primaryCondition,
    required this.totalSessions,
    required this.lastVisit,
  });

  Patient copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? phone,
    String? email,
    String? avatar,
    String? primaryCondition,
    int? totalSessions,
    DateTime? lastVisit,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      primaryCondition: primaryCondition ?? this.primaryCondition,
      totalSessions: totalSessions ?? this.totalSessions,
      lastVisit: lastVisit ?? this.lastVisit,
    );
  }
}
