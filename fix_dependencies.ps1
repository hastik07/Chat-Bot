# Flutter Dependency Fix Script
Write-Host "🔧 Fixing Flutter dependencies..." -ForegroundColor Green

# Clean the project
Write-Host "🧹 Cleaning Flutter project..."
flutter clean

# Delete pubspec.lock to force dependency resolution
Write-Host "🗑️ Removing pubspec.lock..."
if (Test-Path "pubspec.lock") {
    Remove-Item "pubspec.lock"
}

# Get dependencies
Write-Host "📦 Getting dependencies..."
flutter pub get

# Upgrade dependencies
Write-Host "⬆️ Upgrading dependencies..."
flutter pub upgrade

Write-Host "✅ Dependencies fixed! Try running the app now." -ForegroundColor Green
Write-Host "Run: flutter run" -ForegroundColor Yellow 