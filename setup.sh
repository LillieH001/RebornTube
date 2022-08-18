set -e
curl -L "https://github.com/tanersener/ffmpeg-kit/releases/download/v4.5.1.LTS/ffmpeg-kit-full-4.5.1.LTS-ios-framework.zip" --output ffmpeg-kit-full-4.5.1.LTS-ios-framework.zip
unzip ffmpeg-kit-full-4.5.1.LTS-ios-framework.zip -d Resources/Frameworks
rm -rf ffmpeg-kit-full-4.5.1.LTS-ios-framework.zip
echo Done