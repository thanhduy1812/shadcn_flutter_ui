import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:vnl_common_ui/shadcn_flutter.dart';

class AvatarGroupTile extends StatelessWidget implements IComponentPage {
  const AvatarGroupTile({super.key});

  @override
  String get title => 'VNLAvatar Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'avatar_group',
      title: 'VNLAvatar Group',
      scale: 1.5,
      center: true,
      example: VNLAvatarGroup.toLeft(children: [
        VNLAvatar(
          initials: VNLAvatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.red,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.green,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.blue,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.yellow,
        ),
      ]),
    );
  }
}
