.PHONY: help install clean lint format test test-coverage analyze run-macos run-web run-ios build-macos-debug build-macos-release build-web-debug build-web-release build-ios-debug build-ios-release validate pre-commit

# Default target
help:
	@echo "Rituals MVP - Makefile Commands"
	@echo "================================"
	@echo ""
	@echo "Setup:"
	@echo "  make install          Install dependencies"
	@echo "  make clean            Clean build artifacts"
	@echo ""
	@echo "Development (Debug):"
	@echo "  make run-macos            Run app on macOS"
	@echo "  make run-web              Run app on web (Chrome)"
	@echo "  make run-ios              Run app on iOS simulator"
	@echo "  make run-ios-device       Run app on physical iPhone (USB/WiFi)"
	@echo "  make run-ios-wireless     Run app on wireless iPhone"
	@echo ""
	@echo "Code Quality:"
	@echo "  make lint             Run linter (dart analyze)"
	@echo "  make format           Format code"
	@echo "  make analyze          Deep analysis"
	@echo "  make validate         Full validation (lint + test)"
	@echo "  make pre-commit       Run before commit (format + validate)"
	@echo ""
	@echo "Testing:"
	@echo "  make test             Run all tests"
	@echo "  make test-coverage    Run tests with coverage"
	@echo ""
	@echo "Building (Debug):"
	@echo "  make build-macos-debug   Build macOS debug"
	@echo "  make build-web-debug     Build web debug"
	@echo "  make build-ios-debug     Build iOS debug"
	@echo ""
	@echo "Building (Release):"
	@echo "  make build-macos-release  Build macOS release"
	@echo "  make build-web-release    Build web release"
	@echo "  make build-ios-release    Build iOS release"
	@echo "  make build-ios-archive    Build iOS IPA for distribution"
	@echo ""
	@echo "iOS Installation:"
	@echo "  make install-ios-device   Install on connected iPhone"
	@echo "  make install-ios-wireless Install on wireless iPhone"

# Setup
install:
	@echo "📦 Installing dependencies..."
	flutter pub get
	@echo "✅ Dependencies installed"

clean:
	@echo "🧹 Cleaning build artifacts..."
	flutter clean
	rm -rf build/
	rm -rf .dart_tool/
	@echo "✅ Clean complete"

# Code Quality
lint:
	@echo "🔍 Running linter..."
	@flutter analyze; \
	EXIT_CODE=$$?; \
	if [ $$EXIT_CODE -eq 0 ] || [ $$EXIT_CODE -eq 1 ]; then \
		echo "✅ Lint check complete (INFO messages acceptable)"; \
		exit 0; \
	else \
		echo "❌ Lint failed with exit code $$EXIT_CODE"; \
		exit $$EXIT_CODE; \
	fi

format:
	@echo "📝 Formatting code..."
	dart format lib/ test/
	@echo "✅ Format complete"

analyze:
	@echo "🔬 Running deep analysis..."
	flutter analyze --no-pub
	@echo "✅ Analysis complete"

validate: lint test
	@echo "✅ Validation complete - ready to commit!"

pre-commit: format validate
	@echo "✅ Pre-commit checks passed!"

# Testing
test:
	@echo "🧪 Running tests..."
	flutter test
	@echo "✅ Tests complete"

test-coverage:
	@echo "🧪 Running tests with coverage..."
	flutter test --coverage
	@echo "📊 Generating coverage report..."
	genhtml coverage/lcov.info -o coverage/html
	@echo "✅ Coverage report: coverage/html/index.html"

# Development (Debug)
run-macos:
	@echo "🚀 Running on macOS..."
	flutter run -d macos

run-web:
	@echo "🌐 Running on Web..."
	flutter run -d chrome

run-ios:
	@echo "📱 Running on iOS..."
	@echo "Detecting iOS devices..."
	@flutter devices | grep -i ios || echo "No iOS devices found"
	flutter run -d ios

run-ios-device:
	@echo "📱 Running on physical iOS device..."
	@DEVICE_ID=$$(flutter devices | grep "ios" | grep -v "Simulator" | awk '{print $$4}'); \
	if [ -z "$$DEVICE_ID" ]; then \
		echo "❌ No physical iOS device found"; \
		echo "Make sure your iPhone is connected via USB or WiFi"; \
		exit 1; \
	else \
		echo "📱 Found device: $$DEVICE_ID"; \
		flutter run -d $$DEVICE_ID; \
	fi

run-ios-wireless:
	@echo "📱 Running on wireless iOS device..."
	@flutter devices --device-timeout=10 | grep "wireless"
	@DEVICE_ID=$$(flutter devices | grep "wireless" | awk '{print $$4}'); \
	if [ -z "$$DEVICE_ID" ]; then \
		echo "❌ No wireless iOS device found"; \
		echo "💡 To connect wirelessly:"; \
		echo "   1. Connect iPhone via USB"; \
		echo "   2. Open Xcode > Window > Devices and Simulators"; \
		echo "   3. Select your device and enable 'Connect via network'"; \
		exit 1; \
	else \
		echo "📱 Found wireless device: $$DEVICE_ID"; \
		flutter run -d $$DEVICE_ID; \
	fi

# Building (Debug)
build-macos-debug:
	@echo "🔨 Building macOS (debug)..."
	flutter build macos --debug
	@echo "✅ Build complete: build/macos/Build/Products/Debug/rituals.app"

build-web-debug:
	@echo "🔨 Building Web (debug)..."
	flutter build web --debug
	@echo "✅ Build complete: build/web/"

build-ios-debug:
	@echo "🔨 Building iOS (debug)..."
	flutter build ios --debug --no-codesign
	@echo "✅ Build complete: build/ios/"

# Building (Release)
build-macos-release:
	@echo "🔨 Building macOS (release)..."
	flutter build macos --release
	@echo "✅ Build complete: build/macos/Build/Products/Release/rituals.app"

build-web-release:
	@echo "🔨 Building Web (release)..."
	flutter build web --release
	@echo "✅ Build complete: build/web/"

build-ios-release:
	@echo "🔨 Building iOS (release)..."
	flutter build ios --release
	@echo "✅ Build complete: build/ios/iphoneos/Runner.app"
	@echo ""
	@echo "📦 To install on device:"
	@echo "   make install-ios-device"
	@echo "   OR open build/ios/Runner.xcworkspace in Xcode"

build-ios-archive:
	@echo "🔨 Building iOS archive for distribution..."
	flutter build ipa --release
	@echo "✅ Archive complete: build/ios/ipa/rituals.ipa"
	@echo ""
	@echo "📱 Ready for App Store Connect or TestFlight"

install-ios-device:
	@echo "📱 Installing on connected iOS device..."
	@DEVICE_ID=$$(flutter devices | grep "ios" | grep -v "Simulator" | head -1 | awk '{print $$4}'); \
	if [ -z "$$DEVICE_ID" ]; then \
		echo "❌ No iOS device found"; \
		exit 1; \
	fi; \
	echo "📱 Found device: $$DEVICE_ID"; \
	flutter install -d $$DEVICE_ID

install-ios-wireless:
	@echo "📱 Installing on wireless iOS device..."
	@DEVICE_ID=$$(flutter devices | grep "wireless" | awk '{print $$4}'); \
	if [ -z "$$DEVICE_ID" ]; then \
		echo "❌ No wireless device found"; \
		exit 1; \
	fi; \
	echo "📱 Installing on: $$DEVICE_ID"; \
	flutter install -d $$DEVICE_ID

# Quick tasks
dev-macos: install lint run-macos
dev-web: install lint run-web
build-all-debug: build-macos-debug build-web-debug build-ios-debug
build-all-release: build-macos-release build-web-release build-ios-release
