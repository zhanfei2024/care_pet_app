import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()

class ProfileState implements Cloneable<ProfileState> {
  int id;
  String avatarImageURL;
  String email;
  int gender;
  int age;
  int birthday;

  ProfileState({this.id, this.avatarImageURL, this.email, this.gender, this.age, this.birthday}) {
    avatarImageURL ??= '';
  }

  @override
  ProfileState clone() {
    return ProfileState()
      ..id = id
      ..avatarImageURL = avatarImageURL
      ..email = email
      ..gender = gender
      ..age = age
      ..birthday = birthday;
  }

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    return _$ProfileStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileStateToJson(this);
}