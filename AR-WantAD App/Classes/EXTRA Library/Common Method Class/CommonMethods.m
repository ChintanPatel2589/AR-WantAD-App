//
//  CommonMethods.m
//  VeeNilam
//
//  Created by Chintan Patel on 5/24/16.
//  Copyright © 2016 Rangam Infotech. All rights reserved.
//

#import "CommonMethods.h"
@implementation CommonMethods

+ (void)saveDataIntoPreference:(NSDictionary *)dataDict forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getLoggedUserValueFromNSUserDefaultsWithKey:(NSString *)key
{
    NSString *value = [[[NSUserDefaults standardUserDefaults] valueForKey:@""] valueForKey:key] ;
    return value ;
}
+ (NSString *)getValueFromNSUserDefaultsWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancelbuttonTitle:(NSString *)cancel okButtonTitle:(NSString *)ok
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:ok, nil];
    [alert show];
    
}
+ (void)showAlertViewWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}
+ (BOOL)isDeviceDateFormatIs24
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    if (is24h)
        return true;
    else
        return false;
}
+ (NSDate *) getDateForString:(NSString *) strDate inFomate:(NSString *) formate {
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//    if ([formate length] == 0) {
//        //formate = @"yyyy-MM-dd hh:mm:ss a";
//        formate = @"MM/dd/yyyy hh:mm a";
//    }
//    [dateFormatter setDateFormat:formate];
//    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
//    //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    NSDate * date = [dateFormatter dateFromString:strDate];
//    dateFormatter = nil;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    NSDate * date = [formatter dateFromString:strDate];
    return date;
}

+ (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (NSString *)checkStr:(NSString *)str withDefaultValue:(NSString *)defaultOutPutValue
{
    if ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"] || str==nil) {
        str=defaultOutPutValue;
    }
    return str;
}

+ (NSString *)checkStr:(NSString *)str
{
    if ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"] || str==nil) {
        str=@"";
    }
    return str;
}
+ (BOOL)isValidStr:(NSString *)str{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str.length == 0) {
        return false;
    }else{
        return true;
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(NSString *) getCurrentDateAndTimeInFormate:(NSString *) formate {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([formate length] == 0) {
        formate = @"yyyy-MM-dd hh:mm:ss a";
    }
    
    [dateFormatter setDateFormat:formate];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    
    NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
    
    
    dateFormatter = nil;
    return currentTime;
}
+ (NSDate *)getCurrentDateAndTimeAsDeviceSetting
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    
    NSDate * date = [dateFormatter dateFromString:currentTime];
    //NSDate *date = [self getDateForString:currentTime inFomate:@""];
   return date;
}
+ (NSString *)getDeviceType
{
    NSString *device;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // iPhone device
        device = @"iPhone";
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // iPad device
        device = @"iPad";
    }
    else {
        // Other device i.e. iPod
        device = @"iPod";
    }
    return device;
}

+ (NSString *)getDeviceUUID
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]])
        return [[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]];
    
    @autoreleasepool {
        
        CFUUIDRef uuidReference = CFUUIDCreate(nil);
        CFStringRef stringReference = CFUUIDCreateString(nil, uuidReference);
        NSString *uuidString = (__bridge NSString *)(stringReference);
        [[NSUserDefaults standardUserDefaults] setObject:uuidString forKey:[[NSBundle mainBundle] bundleIdentifier]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        CFRelease(uuidReference);
        CFRelease(stringReference);
        return uuidString;
    }
}
+ (NSString *)getiOSVerion
{
    NSString *iosVersion;
    if (IOS_8PLUS) {
        // iOS 8.0 and above
        iosVersion = @"iOS 8";
    } else {
        // Anything less than iOS 8.0
        iosVersion = @"iOS 7";
    }
    return iosVersion;
}
+ (void)setRadiousAndBorderToTextField:(UITextField *)textField
{
    [textField.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [textField.layer setBorderWidth:1];
}
+(UIImage*)imageWithIcon:(NSString*)identifier backgroundColor:(UIColor*)bgColor iconColor:(UIColor*)iconColor  fontSize:(int)fontSize
{
    UIImage *icon = [UIImage imageWithIcon:identifier backgroundColor:bgColor iconColor:iconColor fontSize:fontSize];
    return icon;
}
+ (UIBarButtonItem *)getBarButtonItemWithImage:(NSString *)imageName{
    UIButton *tmpBtnSearch = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [tmpBtnSearch setImage:[CommonMethods imageWithIcon:imageName backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    UIBarButtonItem *btnSearch=[[UIBarButtonItem alloc]initWithCustomView:tmpBtnSearch];
    btnSearch.tintColor =[UIColor whiteColor];
    return btnSearch;
}
+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
@end
