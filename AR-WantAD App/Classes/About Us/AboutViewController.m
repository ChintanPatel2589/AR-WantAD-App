//
//  AboutViewController.m
//  AR-WantAD App
//
//  Created by Chintan patel on 28/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setDefaultData
{
    [viewAboutUs.layer setCornerRadius:15];
    
     txtViewDescription.textAlignment = NSTextAlignmentJustified;
    [btnInfo setImage:[CommonMethods imageWithIcon:@"fa-info" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30] forState:UIControlStateNormal];
    
    [btnClose setImage:[CommonMethods imageWithIcon:@"fa-times-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30] forState:UIControlStateNormal];

}
-(void)viewDidAppear:(BOOL)animated
{
    [self setMaskTo:viewTitle byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
}
- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(8.0, 8.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}
- (IBAction)btnCloseTapped:(id)sender{
    
    [self.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
