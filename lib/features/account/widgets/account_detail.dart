import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AccountDetail extends StatelessWidget {
  const AccountDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Text(user.toJson());
  }
}
