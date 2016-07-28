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

@interface CloudRecognitionFinderModeViewController ()
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
                aboutUSViewOBJ.view.frame = self.view.frame;
                [self.view addSubview:aboutUSViewOBJ.view];
                [self.view bringSubviewToFront:aboutUSViewOBJ.view];
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
        }
            break;
        case 2:
        {//twitter
        }
            break;
        case 3:
        {//google+
        }
            break;
        case 4:
        {//LinkIn
        }
            break;
        case 5:
        {//Insta
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
        [self showSocialMediaMenu:btnShare];
    }
    if (isMenuOpen) {
        [self btnMenuTapped:btnMenu];
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
