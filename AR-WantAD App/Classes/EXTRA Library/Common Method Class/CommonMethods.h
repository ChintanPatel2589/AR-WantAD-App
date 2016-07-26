//
//  CommonMethods.h
//  VeeNilam
//
//  Created by Chintan Patel on 5/24/16.
//  Copyright © 2016 Rangam Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface CommonMethods : NSObject
+ (BOOL)isDeviceDateFormatIs24;
+ (void)saveDataIntoPreference:(NSDictionary *)dataDict forKey:(NSString *)key;
+ (NSString *)getValueFromNSUserDefaultsWithKey:(NSString *)key;
+ (NSString *)getLoggedUserValueFromNSUserDefaultsWithKey:(NSString *)key;
+ (NSDate *) getDateForString:(NSString *) strDate inFomate:(NSString *) formate;
+ (BOOL)validateEmailWithString:(NSString*)email;
+ (NSString *)checkStr:(NSString *)str withDefaultValue:(NSString *)defaultOutPutValue;
+ (NSString *)checkStr:(NSString *)str;
+ (BOOL)isValidStr:(NSString *)str;
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancelbuttonTitle:(NSString *)cancel okButtonTitle:(NSString *)ok;
+ (void)showAlertViewWithMessage:(NSString *)msg;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (NSDate *)getCurrentDateAndTimeAsDeviceSetting;
+ (NSString *)getDeviceType;
+ (NSString *)getDeviceUUID;
+ (NSString *)getiOSVerion;
+ (void)setRadiousAndBorderToTextField:(UITextField *)textField;
+(UIImage*)imageWithIcon:(NSString*)identifier backgroundColor:(UIColor*)bgColor iconColor:(UIColor*)iconColor  fontSize:(int)fontSize;
+ (UIBarButtonItem *)getBarButtonItemWithImage:(NSString *)imageName;
+ (BOOL)connected;
@end
