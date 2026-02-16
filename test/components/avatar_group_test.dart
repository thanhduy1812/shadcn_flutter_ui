import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAvatarGroup', () {
    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment.center,
            children: [],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      // Should render as empty SizedBox
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment.center,
            children: [VNLAvatar(initials: 'A')],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('renders with multiple children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
              VNLAvatar(initials: 'C'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(3));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('toLeft factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toLeft(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('toRight factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toRight(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('toStart factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toStart(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('toEnd factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toEnd(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('toTop factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toTop(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('toBottom factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup.toBottom(
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('respects custom gap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment(0.5, 0),
            gap: 10,
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });

    testWidgets('respects clip behavior', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment(0.5, 0),
            clipBehavior: Clip.hardEdge,
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      // Clip behavior is applied to the internal Stack, just verify it renders
    });

    testWidgets('handles different avatar sizes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              VNLAvatar(initials: 'A', size: 30),
              VNLAvatar(initials: 'B', size: 40),
              VNLAvatar(initials: 'C', size: 50),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(3));
    });

    testWidgets('works with VNLAvatarBadge children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              VNLAvatar(initials: 'A'),
              VNLAvatarBadge(child: Text('1')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('calculates correct group size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: VNLAvatarGroup(
              alignment: Alignment(0.5, 0),
              children: [
                VNLAvatar(initials: 'A', size: 40),
                VNLAvatar(initials: 'B', size: 40),
              ],
            ),
          ),
        ),
      );

      final avatarGroupFinder = find.byType(VNLAvatarGroup);
      expect(avatarGroupFinder, findsOneWidget);
      // The group should be sized to contain both overlapping avatars
      final size = tester.getSize(avatarGroupFinder);
      expect(size.width,
          greaterThan(40)); // Should be wider than single avatar due to overlap
      expect(size.height, 40); // Should be same height as avatars
    });

    testWidgets('handles RTL layout with directional alignment',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: VNLAvatarGroup.toStart(
              children: [
                VNLAvatar(initials: 'A'),
                VNLAvatar(initials: 'B'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLAvatarGroup), findsOneWidget);
      expect(find.byType(VNLAvatar), findsNWidgets(2));
    });
  });
}
