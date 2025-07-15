fetch_modules:
	rm pubspec.lock && fvm flutter pub get
refresh_cocaopods:
	cd ios && pod deintegrate && pod repo update && pod update && pod install && cd ..
all:
	rm -rf build && rm pubspec.lock && fvm flutter clean && fvm flutter pub get && fvm dart run build_runner build --delete-conflicting-outputs && cd ios && pod deintegrate && pod repo update && pod update && pod install && cd ..

gen_all:
	fvm dart run build_runner build --delete-conflicting-outputs

gen_assets:
	fvm dart run build_runner build --build-filter='/**.gen.dart' --delete-conflicting-outputs

gen_freezed:
	fvm dart run build_runner build --build-filter='/**.freezed.dart' --delete-conflicting-outputs

gen_booking:
	fvm dart run build_runner build --build-filter='lib/feature/booking/**.*.dart' --delete-conflicting-outputs

gen_noti:
	fvm dart run build_runner build --build-filter='lib/feature/notification/**.*.dart' --delete-conflicting-outputs

gen_transaction:
	fvm dart run build_runner build --build-filter='lib/feature/transactions/**.*.dart' --delete-conflicting-outputs

gen_user:
	fvm dart run build_runner build --build-filter='lib/feature/user/**.*.dart' --delete-conflicting-outputs

gen_referral:
	fvm dart run build_runner build --build-filter='lib/feature/referral/**.*.dart' --delete-conflicting-outputs

gen_location:
	fvm dart run build_runner build --build-filter='lib/feature/location/**.*.dart' --delete-conflicting-outputs

genl10n:
	fvm flutter gen-l10n

get:
	fvm flutter pub get

fix:
	dart fix --apply

release-dev:
	fvm flutter build appbundle --flavor dev -t lib/main_dev.dart

release-prod:
	fvm flutter build appbundle --flavor prod -t lib/main.dart