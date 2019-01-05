//
//  ViewController.h
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"

@interface ViewController : UIViewController <CustomMenuDelegate>

- (IBAction)actionShowMenu:(UIBarButtonItem *)sender;

@end

