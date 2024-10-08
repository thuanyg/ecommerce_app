import 'package:ecommerce_app/features/user/data/models/user.dart';

abstract class PersonalEvent {}
class PersonalLoadInformation extends PersonalEvent{
  String id;
  PersonalLoadInformation(this.id);
}

class PersonalUpdate extends PersonalEvent{
  User user;
  PersonalUpdate(this.user);
}
