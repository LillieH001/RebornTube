static int __isOSVersionAtLeast(int major, int minor, int patch) { NSOperatingSystemVersion version; version.majorVersion = major; version.minorVersion = minor; version.patchVersion = patch; return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version]; }

@interface UITableView ()
@property(nonatomic) CGFloat sectionHeaderTopPadding API_AVAILABLE(ios(15.0));
@end

@interface UITabBar ()
@property (nonatomic, readwrite, copy, nullable) UITabBarAppearance *scrollEdgeAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(15.0));
@end