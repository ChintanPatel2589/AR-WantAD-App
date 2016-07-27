//
//  SocialMediaViewController.h
//  AR-WantAD App
//
//  Created by Chintan patel on 26/07/16.
//  Copyright © 2016 Chintan patel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SocialMediaViewControllerDelegate<NSObject>
- (void)menuSocialMediaTappedWithIndex:(NSInteger)tappedIndex;
@end

@interface SocialMediaViewController : UIViewController
{
    __weak id<SocialMediaViewControllerDelegate> delegate;
}
@property(nonatomic,weak)id<SocialMediaViewControllerDelegate> delegate;
@end
