//
//  SocialMediaViewController.m
//  AR-WantAD App
//
//  Created by Chintan patel on 26/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import "SocialMediaViewController.h"

@interface SocialMediaViewController ()

@end

@implementation SocialMediaViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnMenuTapped:(UIButton *)sender
{
    [self setOtherButtonNotSelectedWithSender:sender];
    [self.delegate menuSocialMediaTappedWithIndex:sender.tag];
}
- (void)setOtherButtonNotSelectedWithSender:(UIButton *)sender
{
    for (int i = 0; i<6; i++) {
        UIButton *btnMenu =(UIButton *)[self.view viewWithTag:i+1];
        if (sender == btnMenu) {
            [btnMenu setSelected:YES];
        }else{
            [btnMenu setSelected:NO];
        }
        
    }
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
