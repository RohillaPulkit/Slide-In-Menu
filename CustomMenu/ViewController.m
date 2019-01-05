//
//  ViewController.m
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

static NSString* const iconEdit = @"";
static NSString* const iconRedirect = @"";
static NSString* const iconForward = @"";
static NSString* const iconMail = @"";
static NSString* const iconDelete = @"";
static NSString* const iconMore = @"";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionShowMenu:(UIBarButtonItem *)sender {
    
    UIView *view = [sender valueForKey:@"view"];
    CGRect buttonRect = [view convertRect:view.bounds toView:nil];
    
    NSLog(@"Button X :%f", CGRectGetMinX(buttonRect));
    NSDictionary *dictEdit = @{@"title": @"Edit",
                               @"icon":iconEdit};
    
    NSDictionary *dictRedirect = @{@"title": @"Redirect",
                                   @"icon":iconRedirect};
    
    NSDictionary *dictForward = @{@"title": @"Forward",
                                  @"icon":iconForward};
    
    NSDictionary *dictMail = @{@"title": @"Send I/O Mail",
                               @"icon":iconMail};
    
    NSDictionary *dictMore = @{@"title": @"More",
                               @"icon":iconMore};
    
    MenuView *menuView = [[MenuView alloc] initMenuFromRect:buttonRect WithOptions:@[dictEdit, dictRedirect, dictForward, dictMail, dictMore]];
    [menuView setDelegate:self];
    [menuView show];
}

#pragma mark - CustomMenuDelegate

-(void)didDismissWithButtonIndex:(NSInteger)buttonIndex{

    NSLog(@"%li",buttonIndex);
}

@end
