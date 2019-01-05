//
//  MenuView.m
//  CustomMenu
//
//  Created by Pulkit Rohilla on 15/03/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

NSArray *arrayMenuOptions;
NSMutableArray *arrayTableRows;
UITableView *menuTable;

int rowIndex;

const static float estimatedRowHeight = 70.0;

-(MenuView *)initMenuFromRect:(CGRect)rect WithOptions:(NSArray *)arrayOptions{
    
    arrayMenuOptions = arrayOptions;
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    self = [[MenuView alloc] initWithFrame:currentWindow.frame];
    self.alpha = 0;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    menuTable = [[UITableView alloc] init];
    menuTable.estimatedRowHeight = estimatedRowHeight;
    menuTable.bounces = NO;
    menuTable.backgroundColor = [UIColor clearColor];
    menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    menuTable.showsHorizontalScrollIndicator = NO;
    menuTable.showsVerticalScrollIndicator = NO;
    
    UINib *nib = [UINib nibWithNibName:@"CustomMenuCell" bundle:nil];
    [menuTable registerNib:nib forCellReuseIdentifier:@"CustomMenuCell"];
    
    [self addSubview:menuTable];
    
    [menuTable setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = @{@"menuTable":menuTable};
    
    NSLog(@"Max X : %f", rect.size.width);
    
    CGFloat barBtnRightPoint = CGRectGetWidth(currentWindow.frame)-CGRectGetMaxX(rect);
    CGFloat barBtnLowerPoint = CGRectGetMaxY(rect) + 30;
    
    NSNumber *rightMargin = [NSNumber numberWithFloat:barBtnRightPoint];
    NSNumber *upperMargin = [NSNumber numberWithFloat:barBtnLowerPoint];
    
    NSDictionary *metrics = @{@"rightMargin": rightMargin,
                              @"upperMargin":upperMargin};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[menuTable]-0-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:viewsDictionary];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-upperMargin-[menuTable]-0-|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:viewsDictionary];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    [self addGestureRecognizer:tapGesture];
    
    return self;
}

#pragma mark - OtherMethods

-(void)show{
    
    menuTable.dataSource = self;
    menuTable.delegate = self;
    
    [MenuView beginAnimations:@"MoveIn" context:nil];
    self.alpha = 1.0;
    [MenuView commitAnimations];
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self];
    
    rowIndex = 0;
    arrayTableRows = [NSMutableArray new];
    [NSTimer scheduledTimerWithTimeInterval:0.065f target:self selector:@selector(performTableUpdates:) userInfo:nil repeats:YES];
    
}

-(void)hide{
    
    [MenuView animateWithDuration:0.25
                       animations:^{self.alpha = 0.0;}
                       completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         
     }];
    
}

- (void)performTableUpdates:(NSTimer*)timer
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [arrayTableRows addObject:[arrayMenuOptions objectAtIndex:rowIndex]];
    [menuTable beginUpdates];
    [menuTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [menuTable endUpdates];
    
    if(rowIndex < [arrayMenuOptions count])
    {
        if([arrayMenuOptions count]-rowIndex==1)
        {
            [timer invalidate];
            rowIndex++;
        }
        else
            rowIndex++;
    }
    
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayTableRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomMenuCell" forIndexPath:indexPath];
    
    NSDictionary *dictAction = [arrayTableRows objectAtIndex:indexPath.row];
    
    cell.lblAction.text = [dictAction objectForKey:@"title"];
    [cell.buttonAction setTitle:[dictAction objectForKey:@"icon"] forState:UIControlStateNormal] ;
    
    cell.buttonIndex = indexPath.row;
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return estimatedRowHeight;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - CustomMenuDelegate

-(void)didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self hide];
    
    [self.delegate didDismissWithButtonIndex:buttonIndex];
}

@end
