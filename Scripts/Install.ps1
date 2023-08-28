# Remove old packages folder
if (Test-Path Packages) {
	Remove-Item -Recurse -Force Packages
}

if (Test-Path ServerPackages) {
	Remove-Item -Recurse -Force ServerPackages
}

# Install packages
wally install

# If ServerPackages doesn't exist, create it.
if (-not (Test-Path ServerPackages)) {
	New-Item -ItemType Directory -Force -Path ServerPackages
}

# Sourcemap generation
rojo.exe sourcemap --output sourcemap.json

# Fix the types (why is this not native???)
wally-package-types.exe --sourcemap sourcemap.json Packages/
