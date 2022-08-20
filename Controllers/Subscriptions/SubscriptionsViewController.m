// Main

#import "SubscriptionsViewController.h"

// Nav Bar

#import "../Search/SearchViewController.h"
#import "../Settings/SettingsViewController.h"

// Tab Bar

#import "../Home/HomeViewController.h"
#import "../History/HistoryViewController.h"
#import "../Playlists/PlaylistsViewController.h"

// Classes

#import "../../Classes/AppColours.h"

// Interface

@interface SubscriptionsViewController ()
{
    // Keys
	UIWindow *boundsWindow;
}
- (void)keysSetup;
- (void)navBarSetup;
- (void)tabBarSetup;
@end

@implementation SubscriptionsViewController

- (void)loadView {
	[super loadView];

	self.title = @"";
	self.view.backgroundColor = [AppColours mainBackgroundColour];

	[self keysSetup];
	[self navBarSetup];
	[self tabBarSetup];
}

- (void)keysSetup {
	boundsWindow = [[UIApplication sharedApplication] keyWindow];
}

- (void)navBarSetup {
	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = @"RebornTube";
	titleLabel.textColor = [AppColours textColour];
	titleLabel.numberOfLines = 1;
	titleLabel.adjustsFontSizeToFitWidth = YES;
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];

    self.navigationItem.leftBarButtonItem = titleButton;

    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    
    self.navigationItem.rightBarButtonItems = @[settingsButton, searchButton];
}

- (void)tabBarSetup {
	UITabBar *tabBar = [[UITabBar alloc] init];
    tabBar.frame = CGRectMake(0, self.view.bounds.size.height - boundsWindow.safeAreaInsets.bottom - 50, self.view.bounds.size.width, 50);
    tabBar.delegate = self;

    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
	UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Subscriptions" image:nil tag:1];
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"History" image:nil tag:2];
    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"Playlists" image:nil tag:3];
    
	tabBar.items = @[tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4];
    tabBar.selectedItem = [tabBar.items objectAtIndex:1];
    [self.view addSubview:tabBar];
}

@end

@implementation SubscriptionsViewController (Privates)

// Nav Bar

- (void)search {
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)settings {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

// Tab Bar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    int selectedTag = tabBar.selectedItem.tag;
	if (selectedTag == 0) {
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
		[self.navigationController pushViewController:homeViewController animated:NO];
    }
	if (selectedTag == 1) {
        SubscriptionsViewController *subscriptionsViewController = [[SubscriptionsViewController alloc] init];
		[self.navigationController pushViewController:subscriptionsViewController animated:NO];
    }
    if (selectedTag == 2) {
        HistoryViewController *historyViewController = [[HistoryViewController alloc] init];
		[self.navigationController pushViewController:historyViewController animated:NO];
    }
    if (selectedTag == 3) {
        PlaylistsViewController *playlistsViewController = [[PlaylistsViewController alloc] init];
		[self.navigationController pushViewController:playlistsViewController animated:NO];
    }
}

@end