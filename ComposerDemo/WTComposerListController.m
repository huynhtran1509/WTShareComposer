//
//  WTComposerListController.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTComposerListController.h"
#import <WTShareComposer/WTShareComposeViewController.h>
#import "WTFacebookService.h"

@interface WTComposerListController ()

@end

@implementation WTComposerListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Demo", @"Composer list controller title");
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = nil;
    
    switch ((WTComposerDemo)indexPath.row)
    {
        case WTComposerDemoTwitter:
            title = NSLocalizedString(@"Twitter", @"Twitter demo label");
            break;
        case WTComposerDemoFacebook:
            title = NSLocalizedString(@"Facebook", @"Facebook demo label");
            break;
        case WTComposerDemoFoursquare:
            title = NSLocalizedString(@"Foursquare", @"Foursquare demo label");
            break;
        default:
            break;
    }
    
    return title;
}


- (WTShareComposeViewController *)shareComposeViewControllerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTShareComposeViewController *controller = nil;
    WTFacebookService *service = [[WTFacebookService alloc] init];
    WTDefaultTheme *theme = [[WTDefaultTheme alloc] init];
    
    switch ((WTComposerDemo)indexPath.row)
    {
        case WTComposerDemoTwitter:
        {
            
            controller = [[WTShareComposeViewController alloc] initWithService:service theme:theme];
            break;
        }
        case WTComposerDemoFacebook:
        {
            controller = [[WTShareComposeViewController alloc] initWithService:service theme:theme];
            break;
        }
        case WTComposerDemoFoursquare:
        {
            controller = [[WTShareComposeViewController alloc] initWithService:service theme:theme];
            break;
        }
        default:
            break;
    }
    
    return controller;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return WTComposerDemoCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self titleForRowAtIndexPath:indexPath];
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"Composers", @"Composers section header title");
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTShareComposeViewController *controller = [self shareComposeViewControllerForRowAtIndexPath:indexPath];
    [self presentModalShareComposeViewControllerAnimated:controller];
}

@end
