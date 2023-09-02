import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BtmNavigationBar extends ConsumerStatefulWidget {
  /// Constructs an [BtmNavigationBar].
  const BtmNavigationBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BtmNavigationBarState();

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/Chat')) {
      return 0;
    }
    if (location.startsWith('/Home')) {
      return 1;
    }
    if (location.startsWith('/Review')) {
      return 2;
    }
    return 0;
  }
}

class _BtmNavigationBarState extends ConsumerState<BtmNavigationBar> {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 255, 255, 255);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: widget.child,
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.crisis_alert),
                label: 'Chat',
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rate_review_outlined),
                label: 'Review',
                backgroundColor: Color.fromARGB(255, 180, 35, 35),
              ),
            ],
            currentIndex: BtmNavigationBar._calculateSelectedIndex(context),
            backgroundColor: backgroundColor,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (int idx) => _onItemTapped(idx, context),
            fixedColor: const Color.fromARGB(177, 202, 202, 202),
            unselectedItemColor: const Color.fromARGB(154, 147, 151, 165),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedLabelStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 90, 90, 90),
            ),
            selectedLabelStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 90, 90, 90),
            ),
            enableFeedback: false,
          ),
        ));
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/Home');
        break;
      case 1:
        GoRouter.of(context).go('/Home');
        break;
      case 2:
        GoRouter.of(context).go('/Review');
        break;
      case 3:
    }
  }
}
