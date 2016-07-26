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
- (IBAction)btnMenuTapped:(id)sender
{
    
}
- (IBAction)btnHelpTapped:(id)sender
{
    
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

#pragma mark -


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
