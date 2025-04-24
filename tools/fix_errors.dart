import 'dart:io';
import 'dart:convert';

// Common error patterns
final Map<String, String> errorPatterns = {
  r"isn't a type": 'non_type_as_type_argument',
  r"undefined_class": 'undefined_class',
  r"undefined_getter": 'undefined_getter',
  r"undefined name": 'undefined_identifier',
  r"undefined_identifier": 'undefined_identifier',
  r"can't be assigned": 'argument_type_not_assignable',
  r"doesn't conform to the bound": 'type_argument_not_matching_bounds',
};

// Mapping of common errors to their fixes
final Map<String, ErrorFix> commonFixes = {
  'non_type_as_type_argument': ErrorFix(
    description: "Fix for 'X isn't a type' errors",
    matchPattern: r"The name '([^']+)' isn't a type",
    fixType: FixType.prefixVNL
  ),
  'undefined_class': ErrorFix(
    description: "Fix for 'Undefined class' errors", 
    matchPattern: r"Undefined class '([^']+)'",
    fixType: FixType.prefixVNL
  ),
  'undefined_identifier': ErrorFix(
    description: "Fix for 'Undefined name' errors",
    matchPattern: r"Undefined name '([^']+)'",
    fixType: FixType.prefixVNL
  ),
  'undefined_getter': ErrorFix(
    description: "Fix for 'Undefined getter' errors",
    matchPattern: r"The getter '([^']+)' isn't defined",
    fixType: FixType.none  // Usually requires manual fix
  ),
  'argument_type_not_assignable': ErrorFix(
    description: "Fix for type assignment errors",
    matchPattern: r"The argument type '([^']+)' can't be assigned",
    fixType: FixType.none  // Usually requires manual fix
  ),
  'type_argument_not_matching_bounds': ErrorFix(
    description: "Fix for type bound errors",
    matchPattern: r"'([^']+)' doesn't conform to the bound",
    fixType: FixType.none  // Usually requires manual fix
  ),
};

enum FixType {
  prefixVNL,  // Add VNL prefix to the identified name
  none,       // No automatic fix available
}

class ErrorFix {
  final String description;
  final String matchPattern;
  final FixType fixType;
  
  ErrorFix({
    required this.description,
    required this.matchPattern,
    required this.fixType,
  });
}

class ErrorInfo {
  final String filePath;
  final int lineNumber;
  final String errorType;
  final String message;
  final String? identifier;
  
  ErrorInfo({
    required this.filePath,
    required this.lineNumber,
    required this.errorType,
    required this.message,
    this.identifier,
  });
  
  @override
  String toString() {
    return '$filePath:$lineNumber - $errorType: $message${identifier != null ? " (identifier: $identifier)" : ""}';
  }
}

Future<void> main(List<String> args) async {
  // Run dart analyze and capture output
  print('Running dart analyze...');
  
  final result = await Process.run('dart', ['analyze', '--format=json']);
  
  if (result.exitCode != 0) {
    print('Analysis found issues:');
    
    List<ErrorInfo> errors = [];
    
    if (result.stdout.toString().trim().isNotEmpty) {
      try {
        // Try to parse JSON output
        final List<dynamic> analysisOutput = jsonDecode(result.stdout.toString());
        
        for (final error in analysisOutput) {
          final filePath = error['location']['file'];
          final lineNumber = error['location']['startLine'];
          final message = error['message'];
          final errorCode = error['code'];
          
          // Identify the error type
          String errorType = 'unknown';
          String? identifier;
          
          for (final entry in errorPatterns.entries) {
            if (message.contains(entry.key) || errorCode == entry.value) {
              errorType = entry.value;
              
              // Extract the identifier if we have a fix for this error type
              if (commonFixes.containsKey(errorType)) {
                final regex = RegExp(commonFixes[errorType]!.matchPattern);
                final match = regex.firstMatch(message);
                if (match != null) {
                  identifier = match.group(1);
                }
              }
              
              break;
            }
          }
          
          errors.add(ErrorInfo(
            filePath: filePath,
            lineNumber: lineNumber,
            errorType: errorType,
            message: message,
            identifier: identifier,
          ));
        }
      } catch (e) {
        // Fall back to text parsing if JSON parsing fails
        print('Could not parse JSON output. Falling back to text parsing.');
        final lines = result.stdout.toString().split('\n');
        
        for (final line in lines) {
          if (line.trim().isEmpty) continue;
          
          // Try to parse the line in format: file:line:col: error: message
          final parts = line.split(':');
          if (parts.length >= 4) {
            final filePath = parts[0];
            final lineNumber = int.tryParse(parts[1]) ?? 0;
            
            // Join the rest of the parts to get the message
            final message = parts.sublist(3).join(':').trim();
            
            // Identify the error type
            String errorType = 'unknown';
            String? identifier;
            
            for (final entry in errorPatterns.entries) {
              if (message.contains(entry.key)) {
                errorType = entry.value;
                
                // Extract the identifier if we have a fix for this error type
                if (commonFixes.containsKey(errorType)) {
                  final regex = RegExp(commonFixes[errorType]!.matchPattern);
                  final match = regex.firstMatch(message);
                  if (match != null) {
                    identifier = match.group(1);
                  }
                }
                
                break;
              }
            }
            
            errors.add(ErrorInfo(
              filePath: filePath,
              lineNumber: lineNumber,
              errorType: errorType,
              message: message,
              identifier: identifier,
            ));
          }
        }
      }
      
      // Group errors by file
      final Map<String, List<ErrorInfo>> errorsByFile = {};
      
      for (final error in errors) {
        if (!errorsByFile.containsKey(error.filePath)) {
          errorsByFile[error.filePath] = [];
        }
        errorsByFile[error.filePath]!.add(error);
      }
      
      // Process and fix errors
      print('Found ${errors.length} errors in ${errorsByFile.length} files.');
      
      // Group errors by type
      final Map<String, List<ErrorInfo>> errorsByType = {};
      
      for (final error in errors) {
        if (!errorsByType.containsKey(error.errorType)) {
          errorsByType[error.errorType] = [];
        }
        errorsByType[error.errorType]!.add(error);
      }
      
      // Print summary
      print('\nError summary:');
      for (final entry in errorsByType.entries) {
        final errorType = entry.key;
        final count = entry.value.length;
        final fix = commonFixes[errorType];
        final fixStatus = fix != null && fix.fixType != FixType.none ? 'Automatic fix available' : 'Manual fix required';
        
        print('- $errorType: $count errors ($fixStatus)');
      }
      
      // Ask user if they want to apply automatic fixes
      print('\nWould you like to apply automatic fixes? (y/n)');
      final answer = stdin.readLineSync()?.toLowerCase();
      
      if (answer == 'y' || answer == 'yes') {
        print('\nApplying automatic fixes...');
        
        int fixCount = 0;
        
        // Process each file
        for (final entry in errorsByFile.entries) {
          final filePath = entry.key;
          final fileErrors = entry.value;
          
          // Only process files that have errors with automatic fixes
          final hasAutomaticFixes = fileErrors.any((error) => 
              commonFixes.containsKey(error.errorType) && 
              commonFixes[error.errorType]!.fixType != FixType.none &&
              error.identifier != null);
          
          if (hasAutomaticFixes) {
            print('Processing $filePath...');
            
            // Read the file
            final file = File(filePath);
            if (!file.existsSync()) {
              print('  File does not exist, skipping.');
              continue;
            }
            
            String content = await file.readAsString();
            bool changed = false;
            
            // Apply fixes
            for (final error in fileErrors) {
              if (error.identifier != null && 
                  commonFixes.containsKey(error.errorType) && 
                  commonFixes[error.errorType]!.fixType != FixType.none) {
                
                final fix = commonFixes[error.errorType]!;
                final identifier = error.identifier!;
                
                switch (fix.fixType) {
                  case FixType.prefixVNL:
                    // Add VNL prefix to the identifier
                    final pattern = RegExp(r'\b' + identifier + r'\b');
                    final replacements = pattern.allMatches(content).length;
                    
                    if (replacements > 0) {
                      content = content.replaceAll(pattern, 'VNL$identifier');
                      changed = true;
                      fixCount += replacements;
                    }
                    break;
                    
                  case FixType.none:
                    // No automatic fix
                    break;
                }
              }
            }
            
            // Write the file if changed
            if (changed) {
              await file.writeAsString(content);
              print('  Applied fixes to $filePath');
            }
          }
        }
        
        print('\nApplied $fixCount automatic fixes.');
        print('Some errors may still require manual fixes. Run dart analyze again to check.');
      } else {
        print('\nNo fixes applied. You can run this script again later or fix the errors manually.');
      }
    } else {
      print('No issues found during analysis!');
    }
  } else {
    print('No issues found. Your code is clean!');
  }
} 