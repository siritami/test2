#!/bin/bash
# Revanced Extended build
source src/build/utils.sh

# Download requirements
revanced_dl(){
	dl_gh "revanced-patches revanced-integrations revanced-cli" "inotia00" "latest"
}

1() {
	revanced_dl
	# Patch YouTube:
	get_patches_key "youtube-revanced-extended"
	get_apk "com.google.android.youtube" "youtube" "youtube" "google-inc/youtube/youtube" "Bundle_extract"
	split_editor "youtube" "youtube"
	mv src/build/*.rvp download/patches.rvp
	mv src/build/*.jar download/cli.jar
	rm -f download/youtube.apkm
}
2() {
	revanced_dl
	# Patch YouTube Music Extended:
	# Arm64-v8a
	get_patches_key "youtube-music-revanced-extended"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-arm64-v8a" "youtube-music" "google-inc/youtube-music/youtube-music" "arm64-v8a"
	patch "youtube-music-arm64-v8a" "revanced-extended" "inotia"
	# Armeabi-v7a
	get_patches_key "youtube-music-revanced-extended"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-armeabi-v7a" "youtube-music" "google-inc/youtube-music/youtube-music" "armeabi-v7a"
	patch "youtube-music-armeabi-v7a" "revanced-extended" "inotia"
}
3() {
	revanced_dl
	get_apk "com.google.android.youtube" "youtube-lite" "youtube" "google-inc/youtube/youtube" "Bundle_extract"
	# Patch YouTube Lite Arm64-v8a:
	get_patches_key "youtube-revanced-extended"
	split_editor "youtube-lite" "youtube-lite-arm64-v8a" "include" "split_config.arm64_v8a split_config.en split_config.xhdpi split_config.xxxhdpi"
	patch "youtube-lite-arm64-v8a" "revanced-extended" "inotia"
	# Patch YouTube Lite Armeabi-v7a:
	get_patches_key "youtube-revanced-extended"
	split_editor "youtube-lite" "youtube-lite-armeabi-v7a" "include" "split_config.armeabi_v7a split_config.en split_config.xhdpi split_config.xxxhdpi"
	patch "youtube-lite-armeabi-v7a" "revanced-extended" "inotia"
}
case "$1" in
    1)
        1
        ;;
    2)
        2
        ;;
    3)
        3
        ;;
esac