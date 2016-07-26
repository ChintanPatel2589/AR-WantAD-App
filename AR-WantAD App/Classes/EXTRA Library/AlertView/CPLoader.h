//
//  RTViewController.h
//  SpinKit
//
//  Created by Chintan Patel on 10/7/15.
//  Copyright © 2015 Ramon Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTSpinKitView.h"

@interface CPLoader : UIViewController
{
    RTSpinKitView *spinner;
    UIView *loaderView,*blackView;
}

+ (CPLoader *)sharedLoader;
- (void)hideSpinner;
- (void)showLoader :(UIView *)parentView;
@end
