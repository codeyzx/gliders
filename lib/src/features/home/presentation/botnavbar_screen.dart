import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gliders/src/features/home/presentation/barcodescan_screen.dart';
import 'package:gliders/src/features/home/presentation/home_screen.dart';
import 'package:gliders/src/features/profile/presentation/profile_screen.dart';

final currentScreenProvider = StateProvider<Widget>((ref) => const HomeScreen());
final currentIndexProvider = StateProvider<int>((ref) => 0);

class BotNavBarScreen extends ConsumerStatefulWidget {
  const BotNavBarScreen({Key? key}) : super(key: key);
  static const routeName = 'botnavbar';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BotNavBarScreenState();
}

class _BotNavBarScreenState extends ConsumerState<BotNavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(currentScreenProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.0.sp,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                if (index != 1) {
                  ref.read(currentIndexProvider.state).state = index;
                }
                switch (index) {
                  case 0:
                    ref.read(currentScreenProvider.state).state = const HomeScreen();
                    break;
                  case 1:
                    showDialog(context: context, builder: (context) => const BarcodescanScreen());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const BarcodescanScreen(),
                    //     ));
                    break;
                  case 2:
                    ref.read(currentScreenProvider.state).state = const ProfileScreen();
                    break;
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: const Icon(Icons.home),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: const Icon(Icons.qr_code_scanner_rounded),
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: const Icon(Icons.bar_chart_outlined),
                ),
                label: 'Statistic',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
