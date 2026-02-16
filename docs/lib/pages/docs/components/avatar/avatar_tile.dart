import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

class AvatarTile extends StatelessWidget implements IComponentPage {
  const AvatarTile({super.key});

  @override
  String get title => 'VNLAvatar';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'avatar',
      title: 'VNLAvatar',
      scale: 1.5,
      example: VNLCard(
        child: Row(
          children: [
            VNLAvatar(
              initials: VNLAvatar.getInitials('sunarya-thito'),
              provider: const NetworkImage(
                  'https://avatars.githubusercontent.com/u/64018564?v=4'),
            ),
            const Gap(16),
            VNLAvatar(
              initials: VNLAvatar.getInitials('sunarya-thito'),
            ),
          ],
        ),
      ),
    );
  }
}
