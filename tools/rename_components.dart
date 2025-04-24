import 'dart:io';
import 'package:path/path.dart' as path;

// Component mapping (original name -> new name)
final Map<String, String> componentMapping = {
  'PhoneInput': 'VNLPhoneInput',
  'Button': 'VNLButton',
  'TextField': 'VNLTextField',
  'TextArea': 'VNLTextArea',
  'Dialog': 'VNLDialog',
  'Drawer': 'VNLDrawer',
  'Card': 'VNLCard',
  'Tabs': 'VNLTabs',
  'Divider': 'VNLDivider',
  'Switch': 'VNLSwitch',
  'Checkbox': 'VNLCheckbox',
  'RadioGroup': 'VNLRadioGroup',
  'Tooltip': 'VNLTooltip',
  'Badge': 'VNLBadge',
  'Menu': 'VNLMenu',
  'Form': 'VNLForm',
  'Alert': 'VNLAlert',
  'AlertDialog': 'VNLAlertDialog',
  'CircularProgress': 'VNLCircularProgress',
  'Progress': 'VNLProgress',
  'LinearProgress': 'VNLLinearProgress',
  'Skeleton': 'VNLSkeleton',
  'Toast': 'VNLToast',
  'ChipInput': 'VNLChipInput',
  'ColorPicker': 'VNLColorPicker',
  'DatePicker': 'VNLDatePicker',
  'FilePicker': 'VNLFilePicker',
  'FormattedInput': 'VNLFormattedInput',
  'Input': 'VNLInput',
  'AutoComplete': 'VNLAutoComplete',
  'NumberInput': 'VNLNumberInput',
  'InputOTP': 'VNLInputOTP',
  'RadioCard': 'VNLRadioCard',
  'Select': 'VNLSelect',
  'Slider': 'VNLSlider',
  'StarRating': 'VNLStarRating',
  'TimePicker': 'VNLTimePicker',
  'Toggle': 'VNLToggle',
  'MultiSelect': 'VNLMultiSelect',
  'ItemPicker': 'VNLItemPicker',
  'Carousel': 'VNLCarousel',
  'Resizable': 'VNLResizable',
  'Sortable': 'VNLSortable',
  'Steps': 'VNLSteps',
  'Stepper': 'VNLStepper',
  'Timeline': 'VNLTimeline',
  'Scaffold': 'VNLScaffold',
  'AppBar': 'VNLAppBar',
  'CardImage': 'VNLCardImage',
  'Breadcrumb': 'VNLBreadcrumb',
  'Menubar': 'VNLMenubar',
  'NavigationMenu': 'VNLNavigationMenu',
  'Pagination': 'VNLPagination',
  'TabList': 'VNLTabList',
  'TabPane': 'VNLTabPane',
  'Tree': 'VNLTree',
  'NavigationBar': 'VNLNavigationBar',
  'NavigationRail': 'VNLNavigationRail',
  'ExpandableSidebar': 'VNLExpandableSidebar',
  'NavigationSidebar': 'VNLNavigationSidebar',
  'DotIndicator': 'VNLDotIndicator',
  'HoverCard': 'VNLHoverCard',
  'Popover': 'VNLPopover',
  'Sheet': 'VNLSheet',
  'Swiper': 'VNLSwiper',
  'Window': 'VNLWindow',
  'Chip': 'VNLChip',
  'Calendar': 'VNLCalendar',
  'Command': 'VNLCommand',
  'ContextMenu': 'VNLContextMenu',
  'DropdownMenu': 'VNLDropdownMenu',
  'KeyboardDisplay': 'VNLKeyboardDisplay',
  'ImageTools': 'VNLImageTools',
  'RefreshTrigger': 'VNLRefreshTrigger',
  'OverflowMarquee': 'VNLOverflowMarquee',
  // Add more components as needed
};

// Theme class mapping
final Map<String, String> themeMapping = componentMapping.map(
  (key, value) => MapEntry('${key}Theme', '${value}Theme'),
);

// Combined mapping
final Map<String, String> combinedMapping = {
  ...componentMapping,
  ...themeMapping,
};

Future<void> main(List<String> args) async {
  final List<Directory> dirsToProcess = [];
  
  if (args.isNotEmpty) {
    // Process specified directories from command line arguments
    for (final arg in args) {
      final dir = Directory(arg);
      if (dir.existsSync()) {
        dirsToProcess.add(dir);
      } else {
        print('Directory does not exist: ${dir.path}');
      }
    }
  } else {
    // Default directories if no arguments provided
    final srcDir = Directory(path.join('lib', 'src'));
    final docsDir = Directory(path.join('docs', 'lib'));
    
    if (srcDir.existsSync()) {
      dirsToProcess.add(srcDir);
    }
    
    if (docsDir.existsSync()) {
      dirsToProcess.add(docsDir); 
    }
  }
  
  // Process directories
  for (final dir in dirsToProcess) {
    await processDirectory(dir);
  }
  
  print('Component renaming completed!');
  print('Remember to:');
  print('1. Run tests to ensure everything works correctly');
  print('2. Check for any missed references');
  print('3. Update any import/export statements if needed');
}

Future<void> processDirectory(Directory directory) async {
  if (!directory.existsSync()) {
    print('Directory does not exist: ${directory.path}');
    return;
  }
  
  print('Processing directory: ${directory.path}');
  
  await for (final entity in directory.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity);
    }
  }
}

Future<void> processFile(File file) async {
  print('Processing file: ${file.path}');
  
  try {
    String content = await file.readAsString();
    bool changed = false;
    
    // Find all widget classes extending StatelessWidget or StatefulWidget
    final widgetClassRegex = RegExp(r'class\s+(\w+)\s+extends\s+(StatelessWidget|StatefulWidget)');
    final widgetMatches = widgetClassRegex.allMatches(content).toList();
    
    // Extract widget class names
    final widgetClasses = widgetMatches.map((m) => m.group(1)!).toSet();
    
    // Find StateClasses that extend State<WidgetName>
    final stateClassRegex = RegExp(r'class\s+(\w+)\s+extends\s+State<(\w+)>');
    final stateMatches = stateClassRegex.allMatches(content).toList();
    
    // Add state classes to the widget classes set
    final stateClasses = stateMatches.map((m) => m.group(1)!).toSet();
    
    // Define components that must be renamed regardless of widget detection
    // These are high-priority components that should be renamed in all contexts
    final forcedRenameComponents = {
      'Button',
      'Card',
      'Dialog',
      'Drawer',
      'Menu',
      'Tabs',
      'Form',
      'Alert',
      'TextField',
      'Select',
      'Switch',
      'Checkbox',
      'Tooltip',
      'Popover',
      'HoverCard',
    };
    
    // Replace identifiers
    for (final entry in combinedMapping.entries) {
      final oldName = entry.key;
      final newName = entry.value;
      
      final originalContent = content;
      
      // Check if current component is a widget class, theme class, or forced rename component
      final isWidget = widgetClasses.contains(oldName);
      final isState = stateClasses.contains(oldName);
      final isTheme = oldName.endsWith('Theme');
      final isForcedRename = forcedRenameComponents.contains(oldName);
      
      // Only process if it matches our criteria
      if (isWidget || isState || isTheme || isForcedRename) {
        // If it's a forced rename component, do a direct constructor replacement first
        if (isForcedRename) {
          // Replace direct constructor calls for priority components
          content = content.replaceAllMapped(
            RegExp(r'\b' + oldName + r'\b\s*\('),
            (match) {
              changed = true;
              return '$newName(';
            },
          );
        }
        
        // Replace class declarations with word boundary to match exact class names
        content = content.replaceAllMapped(
          RegExp(r'class\s+\b' + oldName + r'\b'),
          (match) {
            changed = true;
            return 'class $newName';
          },
        );
        
        // Replace extends, implements, with references with word boundary
        content = content.replaceAllMapped(
          RegExp(r'(extends|implements|with)\s+\b' + oldName + r'\b'),
          (match) {
            changed = true;
            return '${match.group(1)} $newName';
          },
        );
        
        // Replace covariant parameter types
        content = content.replaceAllMapped(
          RegExp(r'covariant\s+\b' + oldName + r'\b'),
          (match) {
            changed = true;
            return 'covariant $newName';
          },
        );
        
        // Replace field and variable declarations
        content = content.replaceAllMapped(
          RegExp(r'(final|var|const)\s+\b' + oldName + r'\b\s+\w+'),
          (match) {
            changed = true;
            final parts = match.group(0)!.split(RegExp('\\s+'));
            final modifier = parts[0]; // final, var, const
            final varName = parts[2];  // variable name
            return '$modifier $newName $varName';
          },
        );
        
        // Replace method parameter types
        content = content.replaceAllMapped(
          RegExp(r'(\(|,\s*)\b' + oldName + r'\b\s+\w+'),
          (match) {
            final prefix = match.group(1)!;
            final rest = match.group(0)!.substring(prefix.length + oldName.length);
            changed = true;
            return '$prefix$newName$rest';
          },
        );
        
        // Replace generic type parameters with word boundary
        content = content.replaceAllMapped(
          RegExp(r'<\b' + oldName + r'\b[,>]'),
          (match) {
            changed = true;
            final suffix = match.group(0)!.substring(oldName.length + 1);
            return '<$newName$suffix';
          },
        );
        
        // Replace return expressions with constructor calls
        content = content.replaceAllMapped(
          RegExp(r'return\s+[\w\.]*\b' + oldName + r'\b\s*\('),
          (match) {
            final returnStatement = match.group(0)!;
            final parts = returnStatement.split(RegExp('\\s+'));
            // Find the part containing oldName and replace it
            for (int i = 0; i < parts.length; i++) {
              if (parts[i].contains(oldName)) {
                parts[i] = parts[i].replaceAll(RegExp('\\b$oldName\\b'), newName);
                break;
              }
            }
            changed = true;
            return parts.join(' ');
          },
        );
        
        // Replace all other constructor calls with word boundary - more comprehensive pattern
        content = content.replaceAllMapped(
          RegExp(r'(=|\(|,|\s+)\b' + oldName + r'\b\s*\('),
          (match) {
            final prefix = match.group(1)!;
            changed = true;
            return '$prefix$newName(';
          },
        );
        
        // Replace direct constructor references anywhere in the code
        content = content.replaceAllMapped(
          RegExp(r'(?<![a-zA-Z0-9_])\b' + oldName + r'\b(?=\s*\()'),
          (match) {
            changed = true;
            return newName;
          },
        );
        
        // Replace return statements with word boundary (for single identifiers)
        content = content.replaceAllMapped(
          RegExp(r'return\s+\b' + oldName + r'\b\s*;'),
          (match) {
            changed = true;
            return 'return $newName;';
          },
        );
      }
    }
    
    if (changed) {
      print('Updating file: ${file.path}');
      await file.writeAsString(content);
    }
  } catch (e) {
    print('Error processing file ${file.path}: $e');
  }
} 