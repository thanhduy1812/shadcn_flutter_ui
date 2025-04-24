import 'dart:io';
import 'package:path/path.dart' as path;

// Import our generated mapping
import 'class_mapping.dart';

// Define components that must be renamed regardless of widget detection
// These are high-priority components that should be renamed in all contexts
final Set<String> forcedRenameComponents = Set.from(componentMapping.keys);

// Components from external libraries that should not be renamed
final Set<String> externalLibraryComponents = {
  'Skeleton',  // From skeletonizer package
  'Bone',      // From skeletonizer package
  'BoneMock',  // From skeletonizer package
  'Skeletonizer', // From skeletonizer package
  'CountryFlag',  // From country_flags package
  'XFile',        // From cross_file package
  // Add other external library components as needed
};

// Pattern to find all class usage contexts
final List<RegexPattern> renamePatterns = [
  // Class declaration
  RegexPattern(r'class\s+\b([A-Za-z_][A-Za-z0-9_]*)\b', 1, RenameContext.classDeclaration),
  
  // Constructor calls
  RegexPattern(r'\b([A-Za-z_][A-Za-z0-9_]*)\s*\(', 1, RenameContext.constructor),
  
  // Extends/implements/with
  RegexPattern(r'(extends|implements|with)\s+\b([A-Za-z_][A-Za-z0-9_]*)\b', 2, RenameContext.inheritance),
  
  // Type parameters in fields and variables
  RegexPattern(r'(final|var|const)\s+\b([A-Za-z_][A-Za-z0-9_]*)\b\s+\w+', 2, RenameContext.variableDeclaration),
  
  // Method parameter types
  RegexPattern(r'(\(|,\s*)\b([A-Za-z_][A-Za-z0-9_]*)\b\s+\w+', 2, RenameContext.parameterType),
  
  // Generic type parameters
  RegexPattern(r'<\b([A-Za-z_][A-Za-z0-9_]*)\b>', 1, RenameContext.genericType),
  RegexPattern(r'<\b([A-Za-z_][A-Za-z0-9_]*)\b,', 1, RenameContext.genericType),
  
  // Type references in method returns
  RegexPattern(r'\b([A-Za-z_][A-Za-z0-9_]*)\b\s+\w+\([^)]*\)\s*{', 1, RenameContext.returnType),
  
  // Static method calls
  RegexPattern(r'\b([A-Za-z_][A-Za-z0-9_]*)\.\w+\(', 1, RenameContext.staticMethodCall),
  
  // Static field access
  RegexPattern(r'\b([A-Za-z_][A-Za-z0-9_]*)\.\w+\b(?!\()', 1, RenameContext.staticFieldAccess),
  
  // Return statements with constructor
  RegexPattern(r'return\s+new\s+\b([A-Za-z_][A-Za-z0-9_]*)\b', 1, RenameContext.returnConstructor),
  RegexPattern(r'return\s+\b([A-Za-z_][A-Za-z0-9_]*)\b\(', 1, RenameContext.returnConstructor),
  
  // Type cast expressions
  RegexPattern(r'as\s+\b([A-Za-z_][A-Za-z0-9_]*)\b', 1, RenameContext.typeCast),
  
  // is-expressions
  RegexPattern(r'is\s+\b([A-Za-z_][A-Za-z0-9_]*)\b', 1, RenameContext.typeCheck),
  
  // Generic methods with type parameters
  RegexPattern(r'\.\w+<\b([A-Za-z_][A-Za-z0-9_]*)\b>', 1, RenameContext.genericMethodCall),
];

enum RenameContext {
  classDeclaration,
  constructor,
  inheritance,
  variableDeclaration,
  parameterType,
  genericType,
  returnType,
  staticMethodCall,
  staticFieldAccess,
  returnConstructor,
  typeCast,
  typeCheck,
  genericMethodCall,
}

class RegexPattern {
  final RegExp regex;
  final int group;
  final RenameContext context;
  
  RegexPattern(String pattern, this.group, this.context)
      : regex = RegExp(pattern);
}

Future<void> main(List<String> args) async {
  final List<Directory> dirsToProcess = [];
  final List<File> filesToProcess = [];
  
  if (args.isNotEmpty) {
    // Process specified directories or files from command line arguments
    for (final arg in args) {
      final dir = Directory(arg);
      final file = File(arg);
      
      if (dir.existsSync() && dir.statSync().type == FileSystemEntityType.directory) {
        dirsToProcess.add(dir);
      } else if (file.existsSync() && file.statSync().type == FileSystemEntityType.file) {
        filesToProcess.add(file);
      } else {
        print('Path does not exist or is not recognized: ${arg}');
      }
    }
  } else {
    // Default directory if no arguments provided
    final libDir = Directory('lib');
    
    if (libDir.existsSync()) {
      dirsToProcess.add(libDir);
    }
  }
  
  // Ensure we have our mapping data
  if (componentMapping.isEmpty) {
    print('Component mapping is empty. Make sure to run generate_mapping.dart first.');
    return;
  }
  
  // Process individual files
  for (final file in filesToProcess) {
    await processFile(file);
  }
  
  // Process directories
  for (final dir in dirsToProcess) {
    await processDirectory(dir);
  }
  
  print('Class renaming completed!');
  print('Remember to:');
  print('1. Run tests to ensure everything works correctly');
  print('2. Check for any missed references with dart analyze');
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
    
    // Find theme references in build methods
    final themeRefRegex = RegExp(r'ComponentTheme\.maybeOf<(\w+)>\(context\)');
    final themeRefMatches = themeRefRegex.allMatches(content).toList();
    final themeRefs = themeRefMatches.map((m) => m.group(1)!).toSet();
    
    // Find context.dependOnInheritedWidgetOfExactType references
    final inheritedWidgetRegex = RegExp(r'context\.dependOnInheritedWidgetOfExactType<(\w+)>\(\)');
    final inheritedWidgetMatches = inheritedWidgetRegex.allMatches(content).toList();
    final inheritedWidgetRefs = inheritedWidgetMatches.map((m) => m.group(1)!).toSet();
    
    // Add extra mappings from theme references
    final Map<String, String> extraMappings = {};
    
    // Create a local mapping for this file
    Map<String, String> localMapping = Map.from(combinedMapping);
    
    // Add theme references that need renaming
    for (final ref in [...themeRefs, ...inheritedWidgetRefs]) {
      if (ref.endsWith('Theme') && !ref.startsWith('VNL')) {
        final baseName = ref.substring(0, ref.length - 5);
        if (componentMapping.containsKey(baseName)) {
          extraMappings[ref] = 'VNL$ref';
        }
      }
    }
    
    // Update the local mapping with extra mappings
    localMapping.addAll(extraMappings);
    
    // Track renamed classes to avoid double-renaming
    final Set<String> alreadyRenamed = {};
    
    // Apply replacements using our patterns
    for (final pattern in renamePatterns) {
      final matches = pattern.regex.allMatches(content).toList();
      
      // Process matches in reverse order to avoid index shifts
      for (int i = matches.length - 1; i >= 0; i--) {
        final match = matches[i];
        final capturedText = match.group(pattern.group)!;
        
        // Skip already renamed classes in this round
        if (alreadyRenamed.contains(capturedText)) continue;
        
        // Check if we should rename this class
        if (localMapping.containsKey(capturedText) && 
            !externalLibraryComponents.contains(capturedText)) {
          
          final newName = localMapping[capturedText]!;
          final fullMatch = match.group(0)!;
          
          // Decide whether to rename based on the context
          bool shouldRename = false;
          
          switch (pattern.context) {
            case RenameContext.classDeclaration:
              // Always rename class declarations
              shouldRename = true;
              break;
              
            case RenameContext.constructor:
              // Rename constructors for widgets and forced components
              shouldRename = widgetClasses.contains(capturedText) || 
                             forcedRenameComponents.contains(capturedText);
              break;
              
            case RenameContext.inheritance:
              // Always rename in inheritance context
              shouldRename = true;
              break;
              
            case RenameContext.typeCheck:
            case RenameContext.typeCast:
              // Always rename in type checks and casts
              shouldRename = true;
              break;
              
            default:
              // For other contexts, rename if it's a forced component or widget
              shouldRename = forcedRenameComponents.contains(capturedText) ||
                             widgetClasses.contains(capturedText) ||
                             capturedText.endsWith('Theme') ||
                             capturedText.endsWith('Controller');
          }
          
          if (shouldRename) {
            // Perform the replacement
            final replacement = fullMatch.replaceFirst(capturedText, newName);
            
            // Get the start and end positions
            final start = match.start;
            final end = match.end;
            
            // Replace the text in the content
            content = content.substring(0, start) + 
                     replacement + 
                     content.substring(end);
                     
            changed = true;
            
            // Add to already renamed set to avoid double-renaming
            alreadyRenamed.add(capturedText);
          }
        }
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