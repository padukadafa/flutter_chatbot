import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MessageLoading extends StatelessWidget {
  const MessageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(left: 24, right: 64),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(BoneMock.name),
          subtitle: Text(BoneMock.paragraph),
        ),
      ),
    );
  }
}
