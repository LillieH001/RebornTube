// Main

#import "FontSettingsViewController.h"

// Classes

#import "../../Classes/AppColours.h"
#import "../../Classes/AppFonts.h"

// Interface

@interface FontSettingsViewController ()
{
    int selectedFontTag;
}
@end

@implementation FontSettingsViewController

- (void)loadView {
	[super loadView];

	self.title = @"Font";
    self.view.backgroundColor = [AppColours mainBackgroundColour];

    UILabel *applyLabel = [[UILabel alloc] init];
	applyLabel.text = @"Apply";
	applyLabel.textColor = [UIColor systemBlueColor];
	applyLabel.numberOfLines = 1;
	[applyLabel setFont:[AppFonts mainFont:applyLabel.font.pointSize]];
	applyLabel.adjustsFontSizeToFitWidth = YES;
	applyLabel.userInteractionEnabled = YES;
	UITapGestureRecognizer *applyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(apply:)];
	applyTap.numberOfTapsRequired = 1;
	[applyLabel addGestureRecognizer:applyTap];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithCustomView:applyLabel];
    self.navigationItem.rightBarButtonItem = applyButton;

    if (@available(iOS 15.0, *)) {
    	[self.tableView setSectionHeaderTopPadding:0.0f];
	}

    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"kFontOption"]) {
        selectedFontTag = 0;
    } else {
        selectedFontTag = [[NSUserDefaults standardUserDefaults] integerForKey:@"kFontOption"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FontSettingsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.backgroundColor = [AppColours viewBackgroundColour];
        cell.textLabel.textColor = [AppColours textColour];
        cell.detailTextLabel.textColor = [AppColours textColour];
        [cell.textLabel setFont:[AppFonts mainFont:cell.textLabel.font.pointSize]];
        [cell.detailTextLabel setFont:[AppFonts mainFont:cell.detailTextLabel.font.pointSize]];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Default";
                cell.tag = 0;
                if (selectedFontTag == 0) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"Minecraft";
                cell.tag = 3;
                if (selectedFontTag == 3) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = @"Tabitha";
                cell.tag = 4;
                if (selectedFontTag == 4) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            if (indexPath.row == 3) {
                cell.textLabel.text = @"Times New Roman";
                cell.tag = 5;
                if (selectedFontTag == 5) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedFontTag = cell.tag;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedFontTag forKey:@"kFontOption"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

@end

@implementation FontSettingsViewController (Privates)

- (void)apply:(UITapGestureRecognizer *)recognizer {
    exit(0); 
}

@end