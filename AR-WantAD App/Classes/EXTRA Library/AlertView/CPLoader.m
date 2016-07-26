//
//  RTViewController.m
//  SpinKit
//
//  Created by Chintan Patel on 10/7/15.
//  Copyright © 2015 Ramon Torres. All rights reserved.
//

#import "CPLoader.h"

@interface CPLoader ()

@end

@implementation CPLoader
static  CPLoader *rtViewController = nil;
+ (CPLoader *)sharedLoader
{
    @synchronized(self) {
        if (rtViewController == nil) {
            rtViewController = [[CPLoader alloc]init];
        }
    }
    return rtViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (void)showLoader :(UIView *)parentView
{
    blackView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    blackView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
    
    loaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    loaderView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7];
    [loaderView.layer setCornerRadius:loaderView.frame.size.width/2];
    
    CGRect screenBounds = [blackView bounds];
    loaderView.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce color:[UIColor whiteColor]];
    screenBounds = [loaderView bounds];
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];
    [loaderView addSubview:spinner];
    [blackView addSubview:loaderView];
    [parentView addSubview:blackView];
    
}
- (void)hideSpinner
{
    if (spinner) {
        [spinner stopAnimating];
        [loaderView removeFromSuperview];
        [spinner removeFromSuperview];
        [blackView removeFromSuperview];
        spinner = nil;
        loaderView = nil;
        blackView = nil;
    }
}

@end
