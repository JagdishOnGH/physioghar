import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock/mock_data.dart';
import '../data/models/models.dart';

class ProfileNotifier extends Notifier<TherapistProfile> {
  @override
  TherapistProfile build() {
    return MockData.initialProfile;
  }

  void updateProfile({
    required String name,
    required String title,
    required String email,
    required String phone,
    required String clinicAddress,
    required String bio,
    required List<String> specializations,
  }) {
    state = state.copyWith(
      name: name,
      title: title,
      email: email,
      phone: phone,
      clinicAddress: clinicAddress,
      bio: bio,
      specializations: specializations,
    );
  }

  void update({
    String? name,
    String? title,
    String? email,
    String? phone,
    String? clinicAddress,
    String? bio,
    List<String>? specializations,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      title: title ?? state.title,
      email: email ?? state.email,
      phone: phone ?? state.phone,
      clinicAddress: clinicAddress ?? state.clinicAddress,
      bio: bio ?? state.bio,
      specializations: specializations ?? state.specializations,
    );
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, TherapistProfile>(ProfileNotifier.new);
