//
//  CustomMenuCell.h
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomMenuDelegate

- (void)didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface CustomMenuCell : UITableViewCell

@property (weak) id<CustomMenuDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *buttonAction;
@property (weak, nonatomic) IBOutlet UILabel *lblAction;
@property (weak, nonatomic) IBOutlet UIView *viewAction;

@property (nonatomic) NSInteger buttonIndex;

- (IBAction)actionDidSelect:(id)sender;

@end
