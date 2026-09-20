import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../constants/enums.dart';

class StatusPill extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final IconData icon;

  const StatusPill({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.icon,
  });

  factory StatusPill.fromSlotStatus(SlotStatus status) {
    switch (status) {
      case SlotStatus.open:
        return const StatusPill(
          label: 'OPEN',
          bgColor: Color(0xFFE2F0EA),
          textColor: AppColors.primary,
          icon: Icons.check_circle_outline,
        );
      case SlotStatus.booked:
        return const StatusPill(
          label: 'BOOKED',
          bgColor: AppColors.accentPale,
          textColor: Color(0xFFB87019),
          icon: Icons.event_available,
        );
      case SlotStatus.blocked:
        return const StatusPill(
          label: 'BLOCKED',
          bgColor: Color(0xFFF2ECE8),
          textColor: Color(0xFF7A6B63),
          icon: Icons.block,
        );
    }
  }

  factory StatusPill.fromRequestStatus(RequestStatus status, {bool isCompleted = false}) {
    if (isCompleted) {
      return const StatusPill(
        label: 'COMPLETED',
        bgColor: Color(0xFFD8ECE4),
        textColor: AppColors.primary,
        icon: Icons.verified,
      );
    }
    switch (status) {
      case RequestStatus.pending:
        return const StatusPill(
          label: 'PENDING',
          bgColor: AppColors.accentPale,
          textColor: Color(0xFFB87019),
          icon: Icons.hourglass_top,
        );
      case RequestStatus.accepted:
        return const StatusPill(
          label: 'UPCOMING',
          bgColor: Color(0xFFD8ECE4),
          textColor: AppColors.primary,
          icon: Icons.calendar_month,
        );
      case RequestStatus.declined:
        return const StatusPill(
          label: 'DECLINED',
          bgColor: AppColors.errorBg,
          textColor: AppColors.error,
          icon: Icons.cancel_outlined,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.ibmPlexMono(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final String patientName;
  final String patientAvatar;
  final String sessionType;
  final String dateString;
  final String timeString;
  final String complaint;
  final Widget? statusPill;
  final List<Widget>? actionButtons;
  final VoidCallback? onTap;

  const SessionCard({
    super.key,
    required this.patientName,
    required this.patientAvatar,
    required this.sessionType,
    required this.dateString,
    required this.timeString,
    required this.complaint,
    this.statusPill,
    this.actionButtons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(patientAvatar),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patientName,
                          style: GoogleFonts.fraunces(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          sessionType,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ?statusPill,
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Color(0xFFEFF2EE)),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Text(
                    '$dateString • $timeString',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (complaint.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  complaint,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
              if (actionButtons != null && actionButtons!.isNotEmpty) ...[
                const SizedBox(height: 14),
                Row(
                  children: actionButtons!
                      .map((btn) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: btn)))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.bgNeutral,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 36, color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.fraunces(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(text),
        ],
      ),
    );
  }
}

class BottomSheetWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const BottomSheetWrapper({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD6DFDC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.fraunces(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textMuted),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
