# Generates generated code
default: (_generate 'build')

# Generates generated code and watches for changes
watch: (_generate 'watch')

# Utility for calling build runner commands
_generate command:
    dart run build_runner {{command}} --delete-conflicting-outputs
