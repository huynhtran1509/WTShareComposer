//
//  WTComposerListController.m
//  WTShareComposer
//
//  Created by Joel Garrett on 8/5/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "WTComposerListController.h"
#import <WTShareComposer/WTShareComposeViewController.h>

#import "WTTwitterService.h"
#import "WTFacebookService.h"
#import "WTFoursquareService.h"

#import "WTTwitterTheme.h"
#import "WTFourSquareTheme.h"
#import "WTFacebookTheme.h"

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
    
    switch ((WTComposerDemo)indexPath.row)
    {
        case WTComposerDemoTwitter:
        {
            WTTwitterTheme *theme = [[WTTwitterTheme alloc] init];
            WTTwitterService *service = [[WTTwitterService alloc] init];
            controller = [[WTShareComposeViewController alloc] initWithService:service theme:theme];
            [controller setInitialText:@"Hello world!"];
            break;
        }
        case WTComposerDemoFacebook:
        {
            WTFacebookTheme *theme = [[WTFacebookTheme alloc] init];
            WTFacebookService *service = [[WTFacebookService alloc] init];
            controller = [[WTShareComposeViewController alloc] initWithService:service theme:theme];
            break;
        }
        case WTComposerDemoFoursquare:
        {
            WTFourSquareTheme *theme = [[WTFourSquareTheme alloc] init];
            WTFoursquareService *service = [[WTFoursquareService alloc] init];
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
