//
//  AboutViewController.h
//  AR-WantAD App
//
//  Created by Chintan patel on 28/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
{
    IBOutlet UIView *viewAboutUs;
    __weak IBOutlet UITextView *txtViewDescription;
    __weak IBOutlet UIButton *btnInfo;
    __weak IBOutlet UIButton *btnClose;
}
@end
