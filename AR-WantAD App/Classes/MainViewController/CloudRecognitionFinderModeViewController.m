//
//  CloudRecognitionSnapPhotoViewController.m
//  craftar-sdk-sampleapp
//
//  Created by Luis Martinell Andreu on 9/17/13.
//  Copyright (c) 2013 Catchoom. All rights reserved.
//

#import "CloudRecognitionFinderModeViewController.h"
#import <CraftARCloudImageRecognitionSDK/CraftARSDK.h>
#import <CraftARCloudImageRecognitionSDK/CraftARCloudRecognition.h>
#import <SafariServices/SafariServices.h>
@interface CloudRecognitionFinderModeViewController ()<SFSafariViewControllerDelegate>
@end

@implementation CloudRecognitionFinderModeViewController

#pragma mark view initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [btnMenu setImage:[CommonMethods imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30] forState:UIControlStateNormal];
    [btnHelp setImage:[CommonMethods imageWithIcon:@"fa-question" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:30] forState:UIControlStateNormal];
    [btnShare setImage:[CommonMethods imageWithIcon:@"fa-share-square-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:40] forState:UIControlStateNormal];
    
    [[CraftARCloudRecognition sharedCloudImageRecognition] setCollectionWithToken:@"cloudrecognition" onSuccess:^{
        NSLog(@"Token set!!");
    } andOnError:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    // Get the instance of the SDK and become delegate
    mSDK = [CraftARSDK sharedCraftARSDK];
    mSDK.delegate = self;
    
    // Get the Cloud recognition module and set 'self' as delegate to receive
    // the SearchProtocol callbacks
    mCloudRecognition = [CraftARCloudRecognition sharedCloudImageRecognition];
    mCloudRecognition.delegate = self;
    
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    // Start Video Preview for search
    [mSDK startCaptureWithView:self._preview];
    if (captureStarted) {
        mCloudRecognition = [CraftARCloudRecognition sharedCloudImageRecognition];
        mCloudRecognition.delegate = self;
        mSDK.searchControllerDelegate = mCloudRecognition.mSearchController;
        [mSDK startFinder];
    }
}

#pragma mark - IBActions 

- (IBAction)btnMenuTapped:(UIButton *)sender
{
    if (isMenuOpen) {
        [self fadeOutAnimationForView:menuOBJ.view];
    }else{
        [self showMenu:sender];
    }
}
- (IBAction)btnHelpTapped:(id)sender
{
    
}
-(void)showMenu:(UIButton *)sender{
    [self hideSocialMediaMenu];
    menuOBJ = [[GeneralMenuViewController alloc]initWithNibName:@"GeneralMenuViewController" bundle:nil];
    menuOBJ.delegate = self;
    [menuView addSubview:menuOBJ.view];
    menuOBJ.view.hidden = true;
    CGRect tmpFrame = menuOBJ.view.frame;
    tmpFrame.origin.y = (sender.frame.origin.y) - (menuOBJ.view.frame.size.height);
    tmpFrame.origin.x = sender.center.x;
    menuOBJ.view.frame = tmpFrame;
    isMenuOpen = true;
    [self fadeInAnimationForView:menuOBJ.view];
}
-(void)hideMenu{
    if (isMenuOpen) {
        isMenuOpen = false;
        [menuOBJ.view removeFromSuperview];
        menuOBJ = nil;
    }
}

#pragma mark - Menu Delegate
- (void)menuTappedWithIndex:(NSInteger)tappedIndex
{
    switch (tappedIndex) {
        case 1:
            {//About US
                aboutUSViewOBJ =[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
                [self.view addSubview:aboutUSViewOBJ.view];
                aboutUSViewOBJ.view.frame = self.view.frame;
                [self.view bringSubviewToFront:aboutUSViewOBJ.view];
                NSLog(@"about us tapped");
            }
            break;
        case 2:
            {//Product Details
            }
            break;
        case 3:
            {//Contact us
            }
            break;
        case 4:
            {//TErms and condition
            }
            break;
            
        default:
            break;
    }
    [self btnMenuTapped:btnMenu];
}
#pragma mark Social Media Menu
-(IBAction)showSocialMediaMenu:(UIButton *)sender{
    [self hideMenu];
    if (isSocialMediaOpen) {
        isSocialMediaOpen = false;
        btnShare.tintColor = [UIColor whiteColor];
        [self fadeOutAnimationForView:menuSocialMedia.view];
    }else{
        [self showSocialMediaWithSender:sender];
    }
}
- (void)showSocialMediaWithSender:(UIButton *)sender
{
    sender.tintColor = [UIColor redColor];
    menuSocialMedia = [[SocialMediaViewController alloc]initWithNibName:@"SocialMediaViewController" bundle:nil];
    menuSocialMedia.delegate = self;
    [self.view addSubview:menuSocialMedia.view];
    menuSocialMedia.view.hidden = true;
    CGRect tmpFrame = menuSocialMedia.view.frame;
    tmpFrame.origin.y = (sender.frame.origin.y + sender.frame.size.height)-5;
    tmpFrame.origin.x = sender.center.x-tmpFrame.size.width;
    menuSocialMedia.view.frame = tmpFrame;
    isSocialMediaOpen = true;
    [self fadeInAnimationForView:menuSocialMedia.view];
}
-(void)hideSocialMediaMenu
{
    if (isSocialMediaOpen) {
        btnShare.tintColor = [UIColor whiteColor];
        isSocialMediaOpen = false;
        [menuSocialMedia.view removeFromSuperview];
        menuSocialMedia = nil;
    }
}
#pragma mark Social Media Menu delegate
- (void)menuSocialMediaTappedWithIndex:(NSInteger)tappedIndex
{
    switch (tappedIndex) {
        case 1:
        {//Facebook
            [self shareOnFacebook];
        }
            break;
        case 2:
        {//twitter
            [self shareOnTwitter];
        }
            break;
        case 3:
        {//google+
            [self showGooglePlusShare:[NSURL URLWithString:@"https://www.google.co.in/"]];
        }
            break;
        case 4:
        {//LinkIn
            [self shareOnLinkeIn];
        }
            break;
        case 5:
        {//Insta
            [self shareImageToInstagram:nil];
        }
            break;
        case 6:
        {//Pinterest
        }
            break;
            
        default:
            break;
    }
    [self showSocialMediaMenu:btnShare];
    [btnShare setSelected:NO];
}
#pragma mark - Social media menu methods
-(void)shareOnFacebook
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPost = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeFacebook];
        [fbPost addURL:[NSURL URLWithString:@"http://www.sophicts.com/"]];
        [fbPost addImage:[UIImage imageNamed:@"ico_fb_active.png"]];
        [fbPost setInitialText:@"AR-WantAD App"];
        [self presentViewController:fbPost animated:YES completion:nil];
        [fbPost setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                default:
                    break;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        UIAlertView *alertViewTwitter = [[UIAlertView alloc]
                                         initWithTitle:@"No Facebook Accounts"
                                         message:@"There are no Facebook accounts configured. You can add or create a Facebook account in Settings."
                                         delegate:self
                                         cancelButtonTitle:@"Settings"
                                         otherButtonTitles:@"Cancel",nil];
        alertViewTwitter.tag = 105;
        [alertViewTwitter show];
    }
}
-(void)shareOnTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *fbPost = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
        [fbPost addURL:[NSURL URLWithString:@"http://www.sophicts.com/"]];
        [fbPost addImage:[UIImage imageNamed:@"ico_fb_active.png"]];
        [fbPost setInitialText:@"AR-WantAD"];
        [self presentViewController:fbPost animated:YES completion:nil];
        [fbPost setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                default:
                    break;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        UIAlertView *alertViewTwitter = [[UIAlertView alloc]
                                          initWithTitle:@"No Twitter Accounts"
                                          message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
                                          delegate:self
                                          cancelButtonTitle:@"Settings"
                                          otherButtonTitles:@"Cancel",nil];
        [alertViewTwitter show];
    }
    
  
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 105) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=FACEBOOK"]];
        }
    }else{
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];
        }
    }
    
}
- (void)showGooglePlusShare:(NSURL*)shareURL {
    
    // Construct the Google+ share URL
    NSURLComponents* urlComponents = [[NSURLComponents alloc]
                                      initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:[shareURL absoluteString]]];
    
    NSURL* url = [urlComponents URL];
    
    if ([SFSafariViewController class]) {
        // Open the URL in SFSafariViewController (iOS 9+)
        SFSafariViewController* controller = [[SFSafariViewController alloc]
                                              initWithURL:url];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        // Open the URL in the device's browser
        [[UIApplication sharedApplication] openURL:url];
    }
}
-(IBAction)shareImageToInstagram:(id)sender
{
    DMActivityInstagram *instagramActivity = [[DMActivityInstagram alloc] init];
    instagramActivity.presentFromButton = (UIBarButtonItem *)sender;
    NSString *shareText = @"CatPaint #catpaint";
    NSURL *shareURL = [NSURL URLWithString:@"http://catpaint.info"];
    
    NSArray *activityItems = @[shareText, shareURL];
    NSArray *applicationActivities = @[instagramActivity];
    NSArray *excludeActivities = @[];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
     //switch for iPhone and iPad.
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            popOver = [[UIPopoverController alloc] initWithContentViewController:activityController];
            popOver.delegate = self;
            [popOver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        } else {
                [self presentViewController:activityController animated:YES completion:^{
                NSLog(@"Activity complete");
        }];
    }
    
}
-(void)shareOnLinkeIn
{
    NSString *shareText = @"AR-WantAD App";
    NSURL *shareURL = [NSURL URLWithString:@"http://www.sophicts.com/"];
    NSArray *items = @[shareText,shareURL];
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:^{
    }];
}
- (void)fadeInAnimationForView:(UIView *)someView
{
    someView.hidden = false;
    [someView setAlpha:0];
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [someView setAlpha:1];
    [UIView commitAnimations];
}
- (void)fadeOutAnimationForView:(UIView *)someView{
    [UIView beginAnimations:@"FadeOut" context:nil];
    [UIView setAnimationDuration:0.4 ];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    if (menuSocialMedia.view == someView) {
        [UIView setAnimationDidStopSelector:@selector(hideSocialMediaMenu)];
    }else{
        [UIView setAnimationDidStopSelector:@selector(hideMenu)];
    }
    
    [someView setAlpha:0];
    [UIView commitAnimations];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(isSocialMediaOpen){
        //[self showSocialMediaMenu:btnShare];
    }
    if (isMenuOpen) {
        //[self btnMenuTapped:btnMenu];
    }
}
#pragma mark Finder mode implementation

- (void) didStartCapture {
    captureStarted=YES;
    // The SDK manages the Single shot search and the Finder Mode search,
    // the cloud recognition is the delegate for doing the searches.
    // This needs to be done after the camera initialization
    mSDK.searchControllerDelegate = mCloudRecognition.mSearchController;
    
    // Set the colleciton we will search using the token.
    [mCloudRecognition setCollectionWithToken:@"32bc2e15be2e4cbe" onSuccess:^{
        NSLog(@"Ready to search!");
        [mSDK startFinder];
    } andOnError:^(NSError *error) {
        NSLog(@"Error setting token: %@", error.localizedDescription);
    }];
}
- (void) didGetSearchResults:(NSArray *)results {
    self._scanningOverlay.hidden = YES;
    [mSDK stopFinder];
    
    if ([results count] >= 1) {
        // Found one item, launch its content on a webView:
        CraftARSearchResult* result = [results objectAtIndex:0];
        
        CraftARItem *item = result.item;
        
        // Open URL in Webview
        UIViewController *webViewController = [[UIViewController alloc] init];
        UIWebView *uiWebView = [[UIWebView alloc] initWithFrame: self.view.frame];
        [uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:item.url]]];
        uiWebView.scalesPageToFit = YES;
        [webViewController.view addSubview: uiWebView];
        [self.navigationController pushViewController:webViewController animated:YES];
        self._scanningOverlay.hidden = YES;
    } else {
        self._scanningOverlay.hidden = NO;
        [self._scanningOverlay setNeedsDisplay];
        [mSDK startFinder];
    }
}
- (void) didFailSearchWithError:(NSError *)error {
    self._scanningOverlay.hidden = NO;
    [self._scanningOverlay setNeedsDisplay];
    [mSDK startFinder];
}

- (void) didValidateToken {
    // Token valid, do nothing
}

#pragma mark view lifecycle

- (void) viewWillDisappear:(BOOL)animated {
    [mSDK stopCapture];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

@end
