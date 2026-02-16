import '../../../shadcn_flutter.dart';

/// Extension on [Widget] providing convenient icon theme utilities.
///
/// Provides methods to wrap icons with predefined size and color themes,
/// making it easy to apply consistent styling to icon widgets throughout
/// an application.
extension IconExtension on Widget {
  /// Wraps the icon with extra-extra-extra-extra small size theme.
  VNLWrappedIcon get iconX4Small {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Small, child: this);
  }

  /// Wraps the icon with extra-extra-extra small size theme.
  VNLWrappedIcon get iconX3Small {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Small, child: this);
  }

  /// Wraps the icon with extra-extra small size theme.
  VNLWrappedIcon get iconX2Small {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Small, child: this);
  }

  /// Wraps the icon with extra small size theme.
  VNLWrappedIcon get iconXSmall {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.xSmall, child: this);
  }

  /// Wraps the icon with small size theme.
  VNLWrappedIcon get iconSmall {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.small, child: this);
  }

  /// Wraps the icon with medium size theme.
  VNLWrappedIcon get iconMedium {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.medium, child: this);
  }

  /// Wraps the icon with large size theme.
  VNLWrappedIcon get iconLarge {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.large, child: this);
  }

  /// Wraps the icon with extra large size theme.
  VNLWrappedIcon get iconXLarge {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.xLarge, child: this);
  }

  /// Wraps the icon with extra-extra large size theme.
  VNLWrappedIcon get iconX2Large {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Large, child: this);
  }

  /// Wraps the icon with extra-extra-extra large size theme.
  VNLWrappedIcon get iconX3Large {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Large, child: this);
  }

  /// Wraps the icon with extra-extra-extra-extra large size theme.
  VNLWrappedIcon get iconX4Large {
    return VNLWrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Large, child: this);
  }

  /// Wraps the icon with muted foreground color.
  ///
  /// Applies a subdued color suitable for secondary or less prominent icons.
  VNLWrappedIcon get iconMutedForeground {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.mutedForeground),
        child: this);
  }

  /// Wraps the icon with destructive foreground color.
  ///
  /// Deprecated: Use alternative color scheme methods instead.
  @Deprecated('Legacy color')
  VNLWrappedIcon get iconDestructiveForeground {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.destructiveForeground),
        child: this);
  }

  /// Wraps the icon with primary foreground color.
  ///
  /// Typically used for icons on primary-colored backgrounds.
  VNLWrappedIcon get iconPrimaryForeground {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primaryForeground),
        child: this);
  }

  /// Wraps the icon with primary color.
  ///
  /// Applies the theme's primary accent color to the icon.
  VNLWrappedIcon get iconPrimary {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primary),
        child: this);
  }

  /// Wraps the icon with secondary color.
  ///
  /// Applies the theme's secondary accent color to the icon.
  VNLWrappedIcon get iconSecondary {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondary),
        child: this);
  }

  /// Wraps the icon with secondary foreground color.
  ///
  /// Typically used for icons on secondary-colored backgrounds.
  VNLWrappedIcon get iconSecondaryForeground {
    return VNLWrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondaryForeground),
        child: this);
  }
}

/// Builder function for creating icon theme data.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [theme] (`ThemeData`): Current theme data.
///
/// Returns: `T` — typically [IconThemeData].
typedef WrappedIconDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

/// A widget that wraps an icon with custom theme data.
///
/// Applies icon theme styling to a child icon widget using a builder
/// function that can access the current context and theme. Useful for
/// applying dynamic icon styles based on theme values.
///
/// Example:
/// ```dart
/// VNLWrappedIcon(
///   data: (context, theme) => IconThemeData(
///     size: 24,
///     color: theme.colorScheme.primary,
///   ),
///   child: Icon(Icons.star),
/// )
/// ```
class VNLWrappedIcon extends StatelessWidget {
  /// Builder function that creates the icon theme data.
  final WrappedIconDataBuilder<IconThemeData> data;

  /// The child icon widget to apply the theme to.
  final Widget child;

  /// Creates a [VNLWrappedIcon].
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>`, required): Theme builder.
  /// - [child] (`Widget`, required): Icon widget to wrap.
  const VNLWrappedIcon({
    super.key,
    required this.data,
    required this.child,
  });

  /// Returns this widget (callable syntax support).
  ///
  /// Allows using the wrapped icon as a callable function.
  Widget call() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = data(context, theme);
    return IconTheme.merge(
      data: iconTheme,
      child: child,
    );
  }

  /// Creates a copy of this wrapped icon with modified icon theme data.
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>?`, optional): New icon theme data builder.
  ///
  /// Returns: A new [VNLWrappedIcon] with merged theme data.
  VNLWrappedIcon copyWith({
    WrappedIconDataBuilder<IconThemeData>? data,
  }) {
    return VNLWrappedIcon(
      data: (context, theme) {
        return data?.call(context, theme).merge(this.data(context, theme)) ??
            this.data(context, theme);
      },
      child: child,
    );
  }
}
