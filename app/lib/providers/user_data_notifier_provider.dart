import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/user_data_model.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataModel>(
        (ref) => UserDataNotifier());

class UserDataNotifier extends StateNotifier<UserDataModel> {
  UserDataNotifier() :
        super( UserDataModel(
          nickname: '',
          pet_category: '',
          region_si: '',
          region_do: '',
          region_dong: '',
          petimg: '',
          petkeyword: '', //수정필요
          intro: '',
      ));
  void updateUserData({
    String? nickname,
    String? pet_category,
    String? region_do,
    String? region_si,
    String? region_dong,
    String? petimg,
    String? petkeyword,
    String? intro,
  }) {
    state = UserDataModel(
        nickname: nickname ?? state.nickname,
        pet_category: pet_category ?? state.pet_category,
        region_do: region_do ?? state.region_do,
        region_si: region_si ?? state.region_si,
        region_dong: region_dong ?? state.region_dong,
        petimg: petimg ?? state.petimg,
        petkeyword: petkeyword ?? state.petkeyword,
        intro: intro ?? state.intro
    );
  }
}