import '../../core/constants/enums.dart';

class TicketComplaint {
  final String id;
  final ComplaintCategory category;
  final String subject;
  final String description;
  final DateTime createdAt;
  final String status;

  TicketComplaint({
    required this.id,
    required this.category,
    required this.subject,
    required this.description,
    required this.createdAt,
    required this.status,
  });
}
