#include "AUGRootListController.h"

@implementation AUGRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Augment" target:self] retain];
	}

	return _specifiers;
}

@end
