#!/bin/bash

# Run rename process script with parallel execution
# This script handles running the rename process in parallel for different directories

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}=== VNL Class Renaming Process ===${NC}"
echo -e "${YELLOW}This script will handle the complete renaming process.${NC}"
echo ""

# Check if we have the required tools
if ! command -v dart &> /dev/null; then
    echo -e "${RED}Dart is not installed. Please install Dart SDK and try again.${NC}"
    exit 1
fi

# Ensure we're in the project root (where pubspec.yaml is located)
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found. Please run this script from the project root directory.${NC}"
    exit 1
fi

# Create tools directory if it doesn't exist
mkdir -p tools

# Step 1: Verify the scripts exist
echo -e "${BLUE}Verifying scripts...${NC}"
required_scripts=(
    "tools/analyze_classes.dart"
    "tools/generate_mapping.dart"
    "tools/enhanced_rename.dart"
    "tools/fix_errors.dart"
    "tools/rename_process.dart"
)

missing_scripts=0
for script in "${required_scripts[@]}"; do
    if [ ! -f "$script" ]; then
        echo -e "${RED}Missing script: $script${NC}"
        missing_scripts=$((missing_scripts+1))
    fi
done

if [ $missing_scripts -gt 0 ]; then
    echo -e "${RED}Please create the missing scripts first.${NC}"
    exit 1
fi

# Step 2: Run the analyze_classes script
echo -e "${BLUE}Step 1: Analyzing classes...${NC}"
dart tools/analyze_classes.dart lib

if [ $? -ne 0 ]; then
    echo -e "${RED}Class analysis failed. Please check the errors and try again.${NC}"
    exit 1
fi

# Step 3: Generate the mapping
echo -e "${BLUE}Step 2: Generating class mapping...${NC}"
dart tools/generate_mapping.dart

if [ $? -ne 0 ]; then
    echo -e "${RED}Mapping generation failed. Please check the errors and try again.${NC}"
    exit 1
fi

# Step 4: Ask for confirmation before performing the rename
echo -e "${YELLOW}⚠️  WARNING: About to perform renaming operations.${NC}"
echo -e "${YELLOW}This will modify your codebase and cannot be easily undone.${NC}"
echo -e "${YELLOW}It is strongly recommended to commit your changes before proceeding.${NC}"
echo ""
read -p "Do you want to continue? (y/n): " confirm

if [[ $confirm != [yY] && $confirm != [yY][eE][sS] ]]; then
    echo -e "${BLUE}Renaming process cancelled.${NC}"
    exit 0
fi

# Step 5: Perform parallel renaming using background jobs
echo -e "${BLUE}Step 3: Running renaming process in parallel...${NC}"

# Define component directories to process in parallel
component_dirs=(
    "lib/src/components/text"
    "lib/src/components/layout"
    "lib/src/components/form"
    "lib/src/components/display"
    "lib/src/components/control"
    "lib/src/components/chart"
    "lib/src/components/navigation"
    "lib/src/components/menu"
    "lib/src/components/overlay"
)

# Run enhanced_rename.dart for each directory in parallel
for dir in "${component_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}Starting rename process for $dir...${NC}"
        dart tools/enhanced_rename.dart "$dir" > "rename_log_$(basename $dir).txt" 2>&1 &
        echo "PID $! processing $dir"
    else
        echo -e "${YELLOW}Directory $dir not found, skipping.${NC}"
    fi
done

# Process other directories separately to avoid conflicts
echo -e "${GREEN}Processing core files...${NC}"
dart tools/enhanced_rename.dart lib/src > rename_log_core.txt 2>&1 &
core_pid=$!

# Wait for all background jobs to complete
echo -e "${BLUE}Waiting for all renaming processes to complete...${NC}"
wait

# Step 6: Run the error detection and fixing
echo -e "${BLUE}Step 4: Analyzing for errors and fixing...${NC}"
dart tools/fix_errors.dart

# Step 7: Final summary
echo -e "${GREEN}Renaming process completed!${NC}"
echo -e "${YELLOW}Please review the changes, run tests, and fix any remaining issues.${NC}"
echo -e "${YELLOW}Log files have been created for each component directory.${NC}"
echo ""
echo -e "${BLUE}== Next steps: ==${NC}"
echo -e "1. Run 'dart analyze' to check for remaining issues"
echo -e "2. Run tests to ensure functionality is preserved"
echo -e "3. Check for any missed references manually"
echo -e "4. Commit your changes if everything looks good" 