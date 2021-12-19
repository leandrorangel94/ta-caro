import 'package:flutter/material.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/bottom_navigator/app_bottom_navigator.dart';
import 'package:ta_caro/shared/widgets/card_product/card_product.dart';
import 'package:ta_caro/shared/widgets/list_tile.dart/app_list_tile.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  void changedIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 126,
                child: ListView.builder(
                  itemBuilder: (context, index) => CardProduct(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              AppListTile(),
              AppListTile(),
              AppListTile(),
            ],
          ),
          Positioned(
            left: 26,
            right: 26,
            bottom: 14,
            child: AppBottomNavigator(
              currentIndex: currentIndex,
              onChanged: changedIndex,
            ),
          ),
        ],
      ),
    );
  }
}
