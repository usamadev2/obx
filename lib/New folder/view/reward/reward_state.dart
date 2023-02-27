import 'package:flutter/material.dart';

import '../../repositories/user_repository.dart';

class RewardState extends ChangeNotifier {
  final userRepo = UserRepository.instance;
}
