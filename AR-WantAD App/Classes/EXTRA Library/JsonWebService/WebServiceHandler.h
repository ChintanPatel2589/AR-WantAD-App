//
//  Common_Method.m
//  ECLCVisualSchedule
//
//  Created by rangam support on 12/19/13.
//
//

#import <Foundation/Foundation.h>
//@protocol WebServiceHandlerDelegate <NSObject>
//- (void) webServiceResponse:(NSDictionary *)response serviceName:(NSString *)name;
//@end
@interface WebServiceHandler : NSObject
{
    //id <WebServiceHandlerDelegate> __weak delegate;
    NSDictionary* headers;
}
@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)NSString *serviceName;
//@property (nonatomic, weak) id <WebServiceHandlerDelegate> delegate;
- (void)callWebServiceWithParam :(NSDictionary *)paramDict withCompletion:(void (^)(NSDictionary *result))block;

+ (WebServiceHandler *) sharedWebServiceHandler;
@end
