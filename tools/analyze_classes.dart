import 'dart:io';

// External library packages to exclude
final Set<String> externalPackages = {
  'package:flutter/',
  'package:flutter_test/',
  'package:skeletonizer/',
  'package:test/',
  'package:meta/',
  'package:vector_math/',
  'package:path/',
  'dart:',
};

// Class prefixes to exclude
final Set<String> excludePrefixes = {
  '_', // Private classes
  'VNL', // Already prefixed classes
};

// Directory patterns to exclude
final Set<String> excludeDirs = {
  'test',
  '.dart_tool',
  'build',
  '.pub-cache',
};

void main(List<String> args) async {
  // Default directory is lib if not specified
  final String targetDir = args.isNotEmpty ? args[0] : 'lib';
  
  print('Analyzing directory: $targetDir');
  
  final Directory directory = Directory(targetDir);
  if (!directory.existsSync()) {
    print('Directory does not exist: $targetDir');
    return;
  }
  
  final Set<String> customClasses = {};
  final Set<String> customWidgets = {};
  
  // Scan for class definitions
  await for (FileSystemEntity entity in directory.list(recursive: true, followLinks: false)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    
    // Skip excluded directories
    if (excludeDirs.any((dir) => entity.path.contains('/$dir/'))) continue;
    
    try {
      final String content = await File(entity.path).readAsString();
      
      // Find class declarations
      final RegExp classRegex = RegExp(r'class\s+([A-Za-z_][A-Za-z0-9_]*)\s+(extends|implements|with|{)');
      final matches = classRegex.allMatches(content);
      
      for (final match in matches) {
        final className = match.group(1)!;
        
        // Skip classes with excluded prefixes
        if (excludePrefixes.any((prefix) => className.startsWith(prefix))) continue;
        
        // Add to our custom classes set
        customClasses.add(className);
        
        // Check if it's a widget class
        if (content.contains('class $className extends StatelessWidget') || 
            content.contains('class $className extends StatefulWidget')) {
          customWidgets.add(className);
        }
      }
    } catch (e) {
      print('Error processing ${entity.path}: $e');
    }
  }
  
  // Write results to files
  final File classesFile = File('custom_classes.txt');
  await classesFile.writeAsString(customClasses.join('\n'));
  
  final File widgetsFile = File('custom_widgets.txt');
  await widgetsFile.writeAsString(customWidgets.join('\n'));
  
  print('Found ${customClasses.length} custom classes');
  print('Found ${customWidgets.length} custom widget classes');
  print('Results written to custom_classes.txt and custom_widgets.txt');
} 