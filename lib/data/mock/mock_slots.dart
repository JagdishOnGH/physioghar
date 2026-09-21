import '../../core/constants/enums.dart';
import '../models/models.dart';

final List<Slot> mockSlotsData = [
  Slot(
    id: 's_01',
    dayName: 'Today',
    timeRange: '09:00 AM - 10:00 AM',
    status: SlotStatus.booked,
    patientName: 'Aarav Sharma',
    patientAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
  ),
  Slot(
    id: 's_02',
    dayName: 'Today',
    timeRange: '10:30 AM - 11:30 AM',
    status: SlotStatus.open,
  ),
  Slot(
    id: 's_03',
    dayName: 'Today',
    timeRange: '02:00 PM - 03:00 PM',
    status: SlotStatus.booked,
    patientName: 'Priya Adhikari',
    patientAvatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=200',
  ),
  Slot(
    id: 's_04',
    dayName: 'Today',
    timeRange: '03:30 PM - 04:30 PM',
    status: SlotStatus.blocked,
  ),
  Slot(
    id: 's_05',
    dayName: 'Today',
    timeRange: '05:00 PM - 06:00 PM',
    status: SlotStatus.open,
  ),
  Slot(
    id: 's_06',
    dayName: 'Tomorrow',
    timeRange: '09:30 AM - 10:30 AM',
    status: SlotStatus.open,
  ),
  Slot(
    id: 's_07',
    dayName: 'Tomorrow',
    timeRange: '11:00 AM - 12:00 PM',
    status: SlotStatus.booked,
    patientName: 'Rohan Karki',
    patientAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
  ),
  Slot(
    id: 's_08',
    dayName: 'Tomorrow',
    timeRange: '03:00 PM - 04:00 PM',
    status: SlotStatus.open,
  ),
];
