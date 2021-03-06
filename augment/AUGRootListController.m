#include "AUGRootListController.h"

@implementation AUGRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Augment" target:self];
	}

	return _specifiers;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	CGRect frame = CGRectMake(0, 0, self.table.bounds.size.width, 127);

	UIImage *headerImage = [[UIImage alloc]
		initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/augment.bundle"] pathForResource:@"AugmentHeader" ofType:@"png"]];

	UIImageView *headerView = [[UIImageView alloc] initWithFrame:frame];
	[headerView setImage:headerImage];
	headerView.backgroundColor = [UIColor blackColor];
	[headerView setContentMode:UIViewContentModeScaleAspectFit];
	[headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

	self.table.tableHeaderView = headerView;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationController.navigationBar.tintColor = Main_Color;
	self.navigationController.navigationController.navigationBar.barTintColor = Nav_Color;
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationController.navigationBar.tintColor = nil;
	self.navigationController.navigationController.navigationBar.barTintColor = nil;
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];

	CGRect wrapperFrame = ((UIView *)self.table.subviews[0]).frame; // UITableViewWrapperView
	CGRect frame = CGRectMake(wrapperFrame.origin.x, self.table.tableHeaderView.frame.origin.y, wrapperFrame.size.width, self.table.tableHeaderView.frame.size.height);

	self.table.tableHeaderView.frame = frame;
}

-(void)applySettings {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                    CFSTR(APPLY),
                                    nil,
                                    nil,
                                    true);
}

@end
