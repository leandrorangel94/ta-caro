import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';

class AppBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  const AppBottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconBottomNavigator(
            icon: Icons.home,
            enabled: currentIndex == 0,
            onTap: () {
              onChanged(0);
            },
          ),
          IconBottomNavigator(
            icon: Icons.add,
            enabled: currentIndex == 1,
            onTap: () {
              onChanged(1);
            },
          ),
          IconBottomNavigator(
            icon: Icons.settings,
            enabled: currentIndex == 2,
            onTap: () {
              onChanged(2);
            },
          ),
        ],
      ),
    );
  }
}

class IconBottomNavigator extends StatelessWidget {
  final Function() onTap;
  final bool enabled;
  final IconData icon;

  const IconBottomNavigator({
    Key? key,
    required this.onTap,
    required this.enabled,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Icon(
          icon,
          color: enabled
              ? AppTheme.colors.textEnabled
              : AppTheme.colors.iconInactive,
        ),
        decoration: BoxDecoration(
            color:
                enabled ? AppTheme.colors.primary : AppTheme.colors.background,
            borderRadius: BorderRadius.circular(12)),
        width: 40,
        height: 40,
      ),
    );
  }
}
