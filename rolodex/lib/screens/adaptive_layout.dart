import 'package:flutter/cupertino.dart';
import 'contacts.dart';

const largeScreenMinWith = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedListId = 0;

  void _onContactListSelected(int id) {
    setState(() {
      selectedListId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= largeScreenMinWith;

        if (isLargeScreen) {
          return _LargeScreenLayout();
        } else {
          return const ContactListsPage(listId: 0);
        }
      },
    );
  }
}

class _LargeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: 320, child: Text("sidebar")),
            Container(width: 1, color: CupertinoColors.separator),
            const Expanded(child: Text('details')),
          ],
        ),
      ),
    );
  }
}
