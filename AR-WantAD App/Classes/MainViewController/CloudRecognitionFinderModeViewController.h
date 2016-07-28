//
//  CloudRecognitionSnapPhotoViewController.h
//  craftar-sdk-sampleapp
//
//  Created by Luis Martinell Andreu on 9/17/13.
//  Copyright (c) 2013 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CraftARCloudImageRecognitionSDK/CraftARSDK.h>
#import <CraftARCloudImageRecognitionSDK/CraftARCloudRecognition.h>
#import "GeneralMenuViewController.h"
#import "SocialMediaViewController.h"
#import "AboutViewController.h"
@interface CloudRecognitionFinderModeViewController : UIViewController<CraftARSDKProtocol, SearchProtocol,GeneralMenuViewControllerDelegate,SocialMediaViewControllerDelegate>
{
    // CraftAR SDK reference
    CraftARSDK * mSDK;
    CraftARCloudRecognition * mCloudRecognition;
    BOOL captureStarted;
    __weak IBOutlet UIButton *btnMenu;
    __weak IBOutlet UIButton *btnHelp;
    __weak IBOutlet UIButton *btnShare;
    __weak IBOutlet UIView *menuView;
    GeneralMenuViewController *menuOBJ;
    SocialMediaViewController *menuSocialMedia;
    AboutViewController *aboutUSViewOBJ;
    BOOL isMenuOpen;
    BOOL isSocialMediaOpen;
    
}

@property (weak, nonatomic) IBOutlet UIView *_preview;
@property (weak, nonatomic) IBOutlet UIView *_scanningOverlay;


@end
