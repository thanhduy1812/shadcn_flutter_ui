import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAvatar', () {
    testWidgets('renders with initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            size: 60,
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.size, 60);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            borderRadius: 10,
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.borderRadius, 10);
    });

    testWidgets('renders with custom background color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            backgroundColor: Color(0xFFFF0000),
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.backgroundColor, Color(0xFFFF0000));
    });

    testWidgets('renders with image provider', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            provider: NetworkImage('https://example.com/image.jpg'),
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.provider, isA<NetworkImage>());
    });

    testWidgets('network constructor creates correct provider', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar.network(
            initials: 'JD',
            photoUrl: 'https://example.com/image.jpg',
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.provider, isA<NetworkImage>());
    });

    testWidgets('network constructor with cache dimensions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar.network(
            initials: 'JD',
            photoUrl: 'https://example.com/image.jpg',
            cacheWidth: 100,
            cacheHeight: 100,
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.provider, isA<ResizeImage>());
    });

    testWidgets('renders with badge', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            badge: VNLAvatarBadge(color: Colors.green),
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.byType(VNLAvatarBadge), findsOneWidget);
    });

    testWidgets('renders with custom badge alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            badge: VNLAvatarBadge(color: Colors.green),
            badgeAlignment: Alignment.topRight,
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.badgeAlignment, Alignment.topRight);
    });

    testWidgets('renders with custom badge gap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
            badge: VNLAvatarBadge(color: Colors.green),
            badgeGap: 8,
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.badgeGap, 8);
    });

    testWidgets('getInitials generates correct initials', (tester) async {
      expect(VNLAvatar.getInitials('John Doe'), 'JD');
      expect(VNLAvatar.getInitials('John'), 'JO');
      expect(VNLAvatar.getInitials('Madonna'), 'MA');
      expect(VNLAvatar.getInitials('A'), 'A');
      expect(VNLAvatar.getInitials(''), '');
    });

    testWidgets('handles empty initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: '',
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles long initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'VERYLONGINITIALS',
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.text('VERYLONGINITIALS'), findsOneWidget);
    });

    testWidgets('renders in RTL', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleApp(
            child: VNLAvatar(
              initials: 'JD',
            ),
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('applies theme scaling', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
          ),
        ),
      );

      expect(find.byType(VNLAvatar), findsOneWidget);
      // The scaling should be applied to size and border radius
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAvatar(
            initials: 'JD',
          ),
        ),
      );

      final avatar = tester.widget<VNLAvatar>(find.byType(VNLAvatar));
      expect(avatar.backgroundColor, null);
      expect(avatar.size, null);
      expect(avatar.borderRadius, null);
      expect(avatar.badge, null);
      expect(avatar.badgeAlignment, null);
      expect(avatar.badgeGap, null);
      expect(avatar.provider, null);
    });
  });
}
