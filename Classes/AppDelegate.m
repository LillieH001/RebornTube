#import "AppDelegate.h"
#import "AppColours.h"
#import "AppHistory.h"
#import "YouTubeLoader.h"
#import "../Controllers/RootViewController.h"
#import "../Controllers/Player/PlayerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	if (@available(iOS 15.0, *)){
        UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
        [navBarAppearance configureWithOpaqueBackground];
        navBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName : [AppColours textColour]};
        navBarAppearance.backgroundColor = [AppColours mainBackgroundColour];
        [UINavigationBar appearance].standardAppearance = navBarAppearance;
        [UINavigationBar appearance].scrollEdgeAppearance = navBarAppearance;

		UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
		[tabBarAppearance configureWithOpaqueBackground];
        tabBarAppearance.backgroundColor = [AppColours mainBackgroundColour];
		[UITabBar appearance].standardAppearance = tabBarAppearance;
        [UITabBar appearance].scrollEdgeAppearance = tabBarAppearance;
    } else {
		UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
        [navBarAppearance configureWithOpaqueBackground];
        navBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName : [AppColours textColour]};
        navBarAppearance.backgroundColor = [AppColours mainBackgroundColour];
        [UINavigationBar appearance].standardAppearance = navBarAppearance;

		UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
		[tabBarAppearance configureWithOpaqueBackground];
        tabBarAppearance.backgroundColor = [AppColours mainBackgroundColour];
		[UITabBar appearance].standardAppearance = tabBarAppearance;
	}
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    NSString *returnURL = [NSString stringWithFormat:@"%@", url];
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
	NSArray *array = [regExp matchesInString:returnURL options:0 range:NSMakeRange(0, returnURL.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
		NSString *videoID = [returnURL substringWithRange:result.range];

        [AppHistory init:videoID];
        [YouTubeLoader init:videoID];
    }
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIViewController *topViewController = [[[[UIApplication sharedApplication] windows] lastObject] rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)topViewController;
            topViewController = nav.topViewController;
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    if ([topViewController isMemberOfClass:[PlayerViewController class]]){
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end