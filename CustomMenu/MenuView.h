//
//  MenuView.h
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMenuCell.h"

@interface MenuView : UIView <UITableViewDataSource, UITableViewDelegate, CustomMenuDelegate>

- (MenuView *)initMenuFromRect:(CGRect)rect WithOptions:(NSArray *)arrayOptions;

@property (weak) id<CustomMenuDelegate> delegate;

- (void)show;
- (void)hide;

@end
