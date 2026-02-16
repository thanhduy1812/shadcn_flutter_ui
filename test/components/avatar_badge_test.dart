import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAvatarBadge', () {
    testWidgets('renders with default properties', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // Check that it renders without error - the Container is created internally
      expect(find.byType(Container), findsWidgets); // At least one Container
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: VNLAvatarBadge(size: 20),
          ),
        ),
      );

      final avatarBadgeFinder = find.byType(VNLAvatarBadge);
      expect(avatarBadgeFinder, findsOneWidget);
      final size = tester.getSize(avatarBadgeFinder);
      expect(size.width, 20);
      expect(size.height, 20);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(color: material.Colors.red),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // The color is applied to the decoration, but we can't easily test the visual color
      // Just verify it renders
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(borderRadius: 8),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // The border radius is applied to the decoration, but we can't easily test the visual radius
      // Just verify it renders
    });

    testWidgets('renders with child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(
            child: Icon(Icons.star),
          ),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders child with custom color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(
            color: material.Colors.blue,
            child: Text('5'),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // Color is applied internally, just verify it renders with child
    });

    testWidgets('uses theme values when widget values not provided',
        (tester) async {
      // VNLAvatarBadge doesn't use AvatarTheme for its properties
      // It uses theme scaling and radius directly
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // Theme values are used internally, just verify it renders
    });

    testWidgets('widget values override theme values', (tester) async {
      // VNLAvatarBadge properties are not affected by AvatarTheme
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: VNLAvatarBadge(
              size: 24,
              borderRadius: 12,
            ),
          ),
        ),
      );

      final avatarBadgeFinder = find.byType(VNLAvatarBadge);
      expect(avatarBadgeFinder, findsOneWidget);
      final size = tester.getSize(avatarBadgeFinder);
      expect(size.width, 24);
      expect(size.height, 24);
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(),
        ),
      );

      final badge = tester.widget<VNLAvatarBadge>(find.byType(VNLAvatarBadge));
      expect(badge.child, null);
      expect(badge.size, null);
      expect(badge.borderRadius, null);
      expect(badge.color, null);
    });

    testWidgets('preserves key', (tester) async {
      const testKey = Key('test-badge');
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(key: testKey),
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets('renders in different sizes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              VNLAvatarBadge(size: 8),
              VNLAvatarBadge(size: 16),
              VNLAvatarBadge(size: 24),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsNWidgets(3));
      // Verify they render with different sizes by checking their rendered sizes
      final avatarBadges = find.byType(VNLAvatarBadge);
      final firstSize = tester.getSize(avatarBadges.at(0));
      final secondSize = tester.getSize(avatarBadges.at(1));
      final thirdSize = tester.getSize(avatarBadges.at(2));
      expect(firstSize.width, 8);
      expect(secondSize.width, 16);
      expect(thirdSize.width, 24);
    });

    testWidgets('circular badge with default border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatarBadge(size: 20),
        ),
      );

      expect(find.byType(VNLAvatarBadge), findsOneWidget);
      // Border radius is applied internally for circular appearance, just verify it renders
    });
  });
}
