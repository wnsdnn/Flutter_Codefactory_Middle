import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/order/view/order_screen.dart';
import 'package:actual/product/view/product_screen.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:actual/user/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final TABS = [
  TabInfo(icon: Icons.home_outlined, label: '홈'),
  TabInfo(icon: Icons.fastfood_outlined, label: '음식'),
  TabInfo(icon: Icons.home_outlined, label: '주문'),
  TabInfo(icon: Icons.person_outline, label: '프로필'),
];

class TabInfo {
  final IconData icon;
  final String label;

  TabInfo({
    required this.icon,
    required this.label,
  });
}

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: Center(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            RestaurantScrenn(),
            ProductScreen(),
            OrderScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: tabController.index,
        onTap: (int index) {
          tabController.animateTo(index);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
