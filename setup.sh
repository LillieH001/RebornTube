set -e
rm -rf Resources/Frameworks ffmpeg-kit-full-5.1.LTS-ios-framework.zip MobileVLCKit-4.0-20221024-0016.tar.xz MobileVLCKit-binary
curl -LO https://github.com/arthenica/ffmpeg-kit/releases/download/v5.1.LTS/ffmpeg-kit-full-5.1.LTS-ios-framework.zip
curl -LO https://artifacts.videolan.org/VLCKit/dev-artifacts-MobileVLCKit-main/MobileVLCKit-4.0-20221024-0016.tar.xz
unzip ffmpeg-kit-full-5.1.LTS-ios-framework.zip -d Resources/Frameworks
tar -xvf MobileVLCKit-4.0-20221024-0016.tar.xz
mv MobileVLCKit-binary/MobileVLCKit.xcframework/ios-arm64_armv7/MobileVLCKit.framework Resources/Frameworks
rm -rf ffmpeg-kit-full-5.1.LTS-ios-framework.zip MobileVLCKit-4.0-20221024-0016.tar.xz MobileVLCKit-binary
echo Done