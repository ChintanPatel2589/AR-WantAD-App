//
//  Common_Method.m
//  ECLCVisualSchedule
//
//  Created by rangam support on 12/19/13.
//
//

#import "WebServiceHandler.h"

@implementation WebServiceHandler
//@synthesize delegate;
@synthesize responseData;
static WebServiceHandler * sharedWebServiceHandler = nil;
+ (WebServiceHandler *) sharedWebServiceHandler {
    
    @synchronized(self) {
        if (sharedWebServiceHandler == nil) {
            sharedWebServiceHandler = [[WebServiceHandler alloc] init];
        }
    }
    return sharedWebServiceHandler;
}
- (void)callWebServiceWithParam :(NSDictionary *)paramDict withCompletion:(void (^)(NSDictionary *result))block
{
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDict options:NSJSONWritingPrettyPrinted error:&error];
        NSLog(@"\n %@  ====> \n %@",self.serviceName,[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding]);
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceURL]];
        [request setHTTPMethod:@"POST"];
        [request addValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsonData];
        NSURLResponse *result= nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&result  error:&error];
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        block(parsedObject);
}

//
//
//#pragma mark NsurlConnection Delegate Methods
//- (void)connection:(NSURLConnection *)connection
//  didFailWithError:(NSError *)error
//{
//    CFRunLoopStop(CFRunLoopGetCurrent());
//}
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    headers = [(NSHTTPURLResponse *)response allHeaderFields];
//    responseData = [NSMutableData data];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [responseData appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    CFRunLoopStop(CFRunLoopGetCurrent());
//    NSError *err;
//    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&err];
//    NSLog(@"WebServicesHandler ===>  %@",parsedObject);
//    [delegate webServiceResponse:parsedObject serviceName:self.serviceName];
//}
//
//=============================================================================//
@end
