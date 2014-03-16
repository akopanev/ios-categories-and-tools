//
//  MDMainViewController.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MAMainViewController.h"

@interface MAMainViewController () <UITableViewDataSource, UITableViewDelegate> {
	NSArray				*_menuList;
}

@end

@implementation MAMainViewController

#pragma mark -
/*
- (NSArray *)categoriesMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"NSFileManager+Tools", @"title",
			 @"moqod & awl", @"subtitle",
			 @"NSFileManagerToolsViewController", @"controllerClass", nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIDevice+Categories", @"title",
			 @"UIDeviceCategoriesViewController", @"controllerClass", nil],
			nil];
}

- (NSArray *)networkMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"Reachability", @"title",
			 @"ReachabilityViewController", @"controllerClass", nil],
			nil];
}

- (NSArray *)dataMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"HTML Parser", @"title",
			 @"HTMLParserViewController", @"controllerClass", nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"SSZipArchive", @"title",
			 @"SSZipArchiveViewController", @"controllerClass", nil],
            [NSDictionary dictionaryWithObjectsAndKeys:
			 @"CoreData", @"title",
			 @"CoreDataViewController", @"controllerClass", nil],
			nil];
}

- (NSArray *)imagesMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIImage+QR", @"title",
			 @"UIImageQRViewController", @"controllerClass", nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIImage+RoundedCorner", @"title",
			 @"UIImageRoundedCornersViewController", @"controllerClass", nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIImage+Tint", @"title",
			 @"UIImageTintViewController", @"controllerClass", nil],
			nil];
}

- (NSArray *)utilMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"AWLLocationManager", @"title",
			 @"AWLLocationServiceViewController", @"controllerClass", nil],nil];
}
*/
- (NSArray *)userInterfaceMenuList {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIColor", @"title",
			 @"MAColorSampleViewController", @"controllerClass", nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"UIImage", @"title",
			 @"MAImageSampleViewController", @"controllerClass", nil],
			
			nil];
}

#pragma mark -

- (id)init {
    if (self = [super init]) {
		_menuList = [[NSArray alloc] initWithObjects:
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"User Interface", @"title",
					  [self userInterfaceMenuList], @"items", nil],
					 nil];
		/*
		_menuList = [[NSArray alloc] initWithObjects:
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"Categories", @"title",
					  [self categoriesMenuList], @"items", nil],
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"Network", @"title",
					  [self networkMenuList], @"items", nil],
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"Data", @"title",
					  [self dataMenuList], @"items", nil],
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"UIImage+Categories", @"title",
					  [self imagesMenuList], @"items", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:
					  @"Util", @"title",
					  [self utilMenuList], @"items", nil],
					 nil];
		 */
    }
    return self;
}

- (void)dealloc {
	[_menuList release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [NSString stringWithFormat:@"iOS Libraries v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];

	UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
	tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	// remove extra separators
	tableView.tableFooterView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	tableView.dataSource = self;
	tableView.delegate = self;
	[self.view addSubview:tableView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.view setNeedsLayout];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _menuList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSDictionary *item = [_menuList objectAtIndex:section];
	return [[item objectForKey:@"items"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSDictionary *item = [_menuList objectAtIndex:section];
	return [item objectForKey:@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if (nil == cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		cell.detailTextLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:12.0f];
	}
	NSDictionary *item = [_menuList objectAtIndex:indexPath.section];
	NSArray *subitems = [item objectForKey:@"items"];
	NSDictionary *subitem = [subitems objectAtIndex:indexPath.row];
	cell.textLabel.text = [subitem objectForKey:@"title"];
	cell.detailTextLabel.text = [[subitem objectForKey:@"controllerClass"] stringByAppendingString:@".h"];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSDictionary *item = [_menuList objectAtIndex:indexPath.section];
	NSArray *subitems = [item objectForKey:@"items"];
	NSDictionary *subitem = [subitems objectAtIndex:indexPath.row];
	Class controllerClass = NSClassFromString([subitem objectForKey:@"controllerClass"]);
	if (controllerClass) {
		UIViewController *sampleController = [[[controllerClass alloc] init] autorelease];
		sampleController.title = [subitem objectForKey:@"title"];
		[self.navigationController pushViewController:sampleController animated:YES];
	} else {
		NSLog(@"%s class %@ does not exist!..", __PRETTY_FUNCTION__, [item objectForKey:@"controllerClass"]);
	}
}


@end
