import 'dart:io';
import 'package:path/path.dart' as path;

// Special cases that should be handled specifically
final Map<String, String> specialCaseMapping = {
  'Button': 'VNLButton',
  'TextField': 'VNLTextField',
  'Dialog': 'VNLDialog',
  'Card': 'VNLCard',
  'Tabs': 'VNLTabs',
  'Switch': 'VNLSwitch',
  'Form': 'VNLForm',
  'Popover': 'VNLPopover',
  'Table': 'VNLTable',
  'Accordion': 'VNLAccordion',
  'Collapsible': 'VNLCollapsible',
  // Add other special cases as needed
};

// Classes to skip (e.g. already prefixed or not to be renamed)
final Set<String> skipClasses = {
  'MaterialApp',
  'Scaffold',
  'Container',
  'Text',
  'Column',
  'Row',
  'ListView',
  'GridView',
  'Padding',
  'Center',
  'InkWell',
  'GestureDetector',
  'Image',
  'Icon',
  'Stack',
  'Expanded',
  'Flexible',
  'SizedBox',
  'BoxDecoration',
  'Theme',
  'Color',
  'BorderRadius',
  'RoundedRectangleBorder',
  'EdgeInsets',
  'InputDecoration',
  'AppBar',
  'Drawer',
  'ColorScheme',
  'BoxConstraints',
  'TextStyle',
  'IconTheme',
  'ThemeData',
  'Decoration',
  'Key',
  'BuildContext',
  'Widget',
  'WidgetState',
  'MainAxisAlignment',
  'CrossAxisAlignment',
  'Size',
  'Navigator',
  'Exception',
  'BorderSide',
  'Border',
  'Icons',
  'Offset',
  'Duration',
  // Add other Flutter/Dart classes to skip
};

void main(List<String> args) async {
  final String classesFile = args.isNotEmpty ? args[0] : 'custom_classes.txt';
  final String widgetsFile = args.length > 1 ? args[1] : 'custom_widgets.txt';
  
  print('Generating mapping from $classesFile and $widgetsFile');
  
  // Check if files exist
  if (!File(classesFile).existsSync()) {
    print('Classes file not found: $classesFile');
    print('Run analyze_classes.dart first to generate this file.');
    return;
  }
  
  // Read the files
  final List<String> customClasses = await File(classesFile).readAsString().then((s) => s.split('\n'));
  List<String> customWidgets = [];
  
  if (File(widgetsFile).existsSync()) {
    customWidgets = await File(widgetsFile).readAsString().then((s) => s.split('\n'));
  }
  
  // Build component mapping
  final Map<String, String> componentMapping = {};
  final Map<String, String> themeMapping = {};
  final Map<String, String> helperMapping = {};
  
  // Process classes
  for (final className in customClasses) {
    if (className.trim().isEmpty) continue;
    
    // Skip reserved classes or classes to exclude
    if (skipClasses.contains(className)) continue;
    
    // Special case mappings
    if (specialCaseMapping.containsKey(className)) {
      componentMapping[className] = specialCaseMapping[className]!;
      continue;
    }
    
    // Check if it's a widget (prioritize widgets)
    if (customWidgets.contains(className)) {
      componentMapping[className] = 'VNL$className';
    } 
    // Check for theme classes
    else if (className.endsWith('Theme')) {
      final baseName = className.substring(0, className.length - 5);
      // Only add if base component exists or is a known component
      if (customClasses.contains(baseName) || specialCaseMapping.containsKey(baseName)) {
        themeMapping[className] = 'VNL$className';
      }
    }
    // Other helper/auxiliary classes
    else if (className.endsWith('Controller') || 
             className.endsWith('Provider') || 
             className.endsWith('Data') || 
             className.endsWith('State') ||
             className.endsWith('Position') ||
             className.endsWith('Helper')) {
      helperMapping[className] = 'VNL$className';
    }
    // Regular class - default to adding VNL prefix
    else {
      componentMapping[className] = 'VNL$className';
    }
  }
  
  // Write the mapping file
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('// AUTO-GENERATED CLASS MAPPING');
  buffer.writeln('// Generated on ${DateTime.now()}');
  buffer.writeln('// Do not modify this file manually');
  buffer.writeln();
  
  // Component mapping
  buffer.writeln('// Component mapping (original name -> new name)');
  buffer.writeln('final Map<String, String> componentMapping = {');
  
  // Sort and write main components
  final sortedComponents = componentMapping.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  
  for (final entry in sortedComponents) {
    buffer.writeln("  '${entry.key}': '${entry.value}',");
  }
  buffer.writeln('};');
  buffer.writeln();
  
  // Theme mapping
  buffer.writeln('// Theme class mapping');
  buffer.writeln('final Map<String, String> themeMapping = {');
  
  // Sort and write theme classes
  final sortedThemes = themeMapping.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  
  for (final entry in sortedThemes) {
    buffer.writeln("  '${entry.key}': '${entry.value}',");
  }
  buffer.writeln('};');
  buffer.writeln();
  
  // Helper mapping
  buffer.writeln('// Helper, controller, and auxiliary class mapping');
  buffer.writeln('final Map<String, String> helperMapping = {');
  
  // Sort and write helper classes
  final sortedHelpers = helperMapping.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  
  for (final entry in sortedHelpers) {
    buffer.writeln("  '${entry.key}': '${entry.value}',");
  }
  buffer.writeln('};');
  buffer.writeln();
  
  // Combined mapping
  buffer.writeln('// Combined mapping for all classes');
  buffer.writeln('final Map<String, String> combinedMapping = {');
  buffer.writeln('  ...componentMapping,');
  buffer.writeln('  ...themeMapping,');
  buffer.writeln('  ...helperMapping,');
  buffer.writeln('};');
  
  // Write the file
  final String outputFile = 'tools/class_mapping.dart';
  await File(outputFile).writeAsString(buffer.toString());
  
  print('Mapping generated with:');
  print('- ${componentMapping.length} components');
  print('- ${themeMapping.length} theme classes');
  print('- ${helperMapping.length} helper classes');
  print('Output written to $outputFile');
} 