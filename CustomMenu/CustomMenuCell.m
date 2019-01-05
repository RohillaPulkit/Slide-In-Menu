//
//  CustomMenuCell.m
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "CustomMenuCell.h"

@implementation CustomMenuCell

- (void)awakeFromNib {
    // Initialization code
    //    self.viewAction.layer.shadowColor = [[UIColor whiteColor] CGColor];
    //    self.buttonAction.layer.shadowColor = [[UIColor whiteColor] CGColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDidSelect:)];
    [self.viewAction addGestureRecognizer:tapGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)actionDidSelect:(id)sender {
    
    [self.delegate didDismissWithButtonIndex:self.buttonIndex];
}

@end
