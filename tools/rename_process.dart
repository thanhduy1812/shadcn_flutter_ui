import 'dart:io';

/// Master script to orchestrate the entire class renaming process
/// This script will:
/// 1. Analyze the codebase to find custom classes
/// 2. Generate the class mapping
/// 3. Run the renaming process
/// 4. Analyze for errors and offer fixes
Future<void> main(List<String> args) async {
  print('Starting VNL prefix renaming process...');
  print('======================================');
  
  // Step 1: Analyze codebase
  print('\n🔍 Step 1: Analyzing codebase for custom classes...');
  await runScript('analyze_classes.dart', ['lib']);
  
  // Step 2: Generate mapping
  print('\n📝 Step 2: Generating class mapping...');
  await runScript('generate_mapping.dart');
  
  // Step 3: Run renaming process - ask for confirmation
  print('\n⚠️ About to perform renaming operation. This will modify your codebase.');
  print('It is strongly recommended to commit any pending changes before proceeding.');
  print('Would you like to continue? (y/n)');
  
  final answer = stdin.readLineSync()?.toLowerCase();
  
  if (answer == 'y' || answer == 'yes') {
    print('\n🔄 Step 3: Running renaming process...');
    
    // Determine target directories/files
    List<String> targets = args.isNotEmpty ? args : ['lib'];
    
    // Run the enhanced rename script
    await runScript('enhanced_rename.dart', targets);
    
    // Step 4: Check for errors and fix
    print('\n🔧 Step 4: Analyzing for errors and fixing...');
    await runScript('fix_errors.dart');
    
    print('\n✅ Renaming process completed!');
    print('Please review the changes, run tests, and fix any remaining issues.');
  } else {
    print('\nRenaming process cancelled by user.');
  }
}

/// Run a script in the tools directory
Future<void> runScript(String scriptName, [List<String> args = const []]) async {
  final scriptPath = path.join('tools', scriptName);
  
  if (!File(scriptPath).existsSync()) {
    print('Error: Script not found: $scriptPath');
    exit(1);
  }
  
  final result = await Process.run('dart', [scriptPath, ...args]);
  
  print(result.stdout);
  
  if (result.stderr.toString().trim().isNotEmpty) {
    print('Errors:');
    print(result.stderr);
  }
  
  if (result.exitCode != 0) {
    print('Script failed with exit code ${result.exitCode}');
    exit(result.exitCode);
  }
}

// Helper for path operations
class path {
  static String join(String part1, String part2) {
    return '$part1/$part2';
  }
} 