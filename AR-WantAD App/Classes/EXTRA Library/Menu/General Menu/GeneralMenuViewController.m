//
//  GeneralMenuViewController.m
//  AR-WantAD App
//
//  Created by Chintan patel on 26/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import "GeneralMenuViewController.h"

@interface GeneralMenuViewController ()

@end

@implementation GeneralMenuViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultData];
    // Do any additional setup after loading the view from its nib.
}
- (void)setDefaultData
{
    imgViewAboutUs.image = [CommonMethods imageWithIcon:@"fa-info" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30];
    
    imgViewProductDetails.image = [CommonMethods imageWithIcon:@"fa-newspaper-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30];
    
    imgViewContactUS.image = [CommonMethods imageWithIcon:@"fa-envelope-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30];
    
    imgViewTermsCondition.image = [CommonMethods imageWithIcon:@"fa-check-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30];
}
- (IBAction)btnMenuTapped:(UIButton *)sender
{
    [self.delegate menuTappedWithIndex:sender.tag];
}
#pragma mark - IBActions
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
