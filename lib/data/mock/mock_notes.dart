import '../models/models.dart';

final List<PatientNote> mockNotesData = [
  PatientNote(
    id: 'n_01',
    patientId: 'p_01',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    title: 'Progress Review — Week 4',
    content: 'Patient reports 40% reduction in lower back pain during morning flexions. SLR test positive at 65 degrees. Continued core stability and pelvic tilts.',
    tag: 'Clinical Progress',
  ),
  PatientNote(
    id: 'n_02',
    patientId: 'p_01',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    title: 'Initial Assessment & Treatment Plan',
    content: 'Acute L4-L5 disc pain with radiation down right thigh. Prescribed McKenzie extension exercises, ice application 3x daily, and gentle spinal traction.',
    tag: 'Assessment',
  ),
  PatientNote(
    id: 'n_03',
    patientId: 'p_02',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    title: 'Post-Op Knee Flexion Benchmark',
    content: 'Achieved 110 degrees active knee flexion with minimal graft strain. Quad activation improving via biofeedback.',
    tag: 'Rehab Goal',
  ),
  PatientNote(
    id: 'n_04',
    patientId: 'p_03',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    title: 'Cervical Traction Session',
    content: 'Applied 15 min manual traction followed by deep tissue massage to upper traps. Reduced tingling in right arm.',
    tag: 'Treatment',
  ),
];
