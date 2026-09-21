import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/constants/enums.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  ComplaintCategory _selectedCategory = ComplaintCategory.appBug;
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  bool _isSubmitted = false;
  String _ticketId = '';

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitted = true;
        _ticketId = 'PG-TKT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      });
    }
  }

  String _getCategoryLabel(ComplaintCategory cat) {
    switch (cat) {
      case ComplaintCategory.appBug:
        return 'App Bug / Technical Issue';
      case ComplaintCategory.schedulingIssue:
        return 'Schedule & Availability Conflict';
      case ComplaintCategory.paymentInquiry:
        return 'Payout & Consultation Fee Question';
      case ComplaintCategory.patientBehavior:
        return 'Patient Conduct / No-Show';
      case ComplaintCategory.other:
        return 'Other General Feedback';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report an Issue',
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _isSubmitted ? _buildSuccessView() : _buildFormView(),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PhysioGhar Support Desk',
            style: GoogleFonts.fraunces(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Have an issue with booking slots, patient encounters, or app features? Submit a ticket below.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          _buildFieldLabel('Category'),
          DropdownButtonFormField<ComplaintCategory>(
            initialValue: _selectedCategory,
            items: ComplaintCategory.values.map((cat) {
              return DropdownMenuItem(
                value: cat,
                child: Text(_getCategoryLabel(cat), style: GoogleFonts.inter(fontSize: 13)),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedCategory = val);
              }
            },
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Subject / Title'),
          TextFormField(
            controller: _subjectCtrl,
            decoration: const InputDecoration(
              hintText: 'e.g. Calendar sync error on Thursday morning',
            ),
            validator: (val) => val == null || val.trim().isEmpty ? 'Subject is required' : null,
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Detailed Description'),
          TextFormField(
            controller: _descCtrl,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Provide details about what happened, steps to reproduce, or relevant patient name...',
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Description is required';
              if (val.trim().length < 10) return 'Please enter at least 10 characters';
              return null;
            },
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            text: 'Submit Ticket',
            icon: Icons.send,
            onPressed: _submitComplaint,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECE9)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.bgLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Issue Reported Successfully',
            style: GoogleFonts.fraunces(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ticket Reference ID:',
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.bgNeutral,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _ticketId,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Our support team will review your report and respond to sarah.jensen@physioghar.org within 24 hours.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            text: 'Report Another Issue',
            backgroundColor: AppColors.bgNeutral,
            textColor: AppColors.textPrimary,
            onPressed: () {
              setState(() {
                _isSubmitted = false;
                _subjectCtrl.clear();
                _descCtrl.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
