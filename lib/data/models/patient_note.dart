class PatientNote {
  final String id;
  final String patientId;
  final DateTime createdAt;
  final String title;
  final String content;
  final String tag;

  PatientNote({
    required this.id,
    required this.patientId,
    required this.createdAt,
    required this.title,
    required this.content,
    required this.tag,
  });

  PatientNote copyWith({
    String? id,
    String? patientId,
    DateTime? createdAt,
    String? title,
    String? content,
    String? tag,
  }) {
    return PatientNote(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
      tag: tag ?? this.tag,
    );
  }
}
