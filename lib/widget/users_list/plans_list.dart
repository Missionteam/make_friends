import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

class PlansList extends ConsumerWidget {
  const PlansList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoListSection(
        header: const Text('My Reminders'),
        children: <CupertinoListTile>[
          CupertinoListTile(
            title: const Text('Open pull request'),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              color: CupertinoColors.activeGreen,
            ),
            trailing: const CupertinoListTileChevron(),
            onTap: () => Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  return const _SecondPage(text: 'Open pull request');
                },
              ),
            ),
          ),
          CupertinoListTile(
            title: const Text('Push to master'),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              color: CupertinoColors.systemRed,
            ),
            additionalInfo: const Text('Not available'),
          ),
          CupertinoListTile(
            title: const Text('View last commit'),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              color: CupertinoColors.activeOrange,
            ),
            additionalInfo: const Text('12 days ago'),
            trailing: const CupertinoListTileChevron(),
            onTap: () => Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  return const _SecondPage(text: 'Last commit');
                },
              ),
            ),
          ),
        ],;
  }
}