//
//  GeneralMenuViewController.h
//  AR-WantAD App
//
//  Created by Chintan patel on 26/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GeneralMenuViewControllerDelegate<NSObject>
- (void)menuTappedWithIndex:(NSInteger)tappedIndex;
@end

@interface GeneralMenuViewController : UIViewController
{
    __weak id<GeneralMenuViewControllerDelegate> delegate;
    __weak IBOutlet UIImageView *imgViewAboutUs;
    __weak IBOutlet UIImageView *imgViewProductDetails;
    __weak IBOutlet UIImageView *imgViewContactUS;
    __weak IBOutlet UIImageView *imgViewTermsCondition;
    
}
@property(nonatomic,weak)id<GeneralMenuViewControllerDelegate> delegate;
@end
