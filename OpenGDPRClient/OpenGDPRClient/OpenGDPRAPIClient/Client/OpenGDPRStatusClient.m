//
//  Copyright © 2018 PubNative. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "OpenGDPRStatusClient.h"
#import "HttpRequest.h"
#import "Logger.h"
#import "OpenGDPREndpoints.h"

@interface OpenGDPRStatusClient () <HttpRequestDelegate>

@property (nonatomic, weak) NSObject <OpenGDPRStatusDelegate> *delegate;

@end

@implementation OpenGDPRStatusClient

- (void)fetchRequestStatusWithDelegate:(NSObject<OpenGDPRStatusDelegate> *)delegate withRequestID:(NSString *)requestID
{
    if (requestID == nil || requestID.length == 0) {
        [self invokeDidFail:[NSError errorWithDomain:@"Invalid requestID" code:0 userInfo:nil]];
    } else if (delegate == nil) {
        [self invokeDidFail:[NSError errorWithDomain:@"Given delegate is nil and required, droping this call" code:0 userInfo:nil]];
    } else {
        self.delegate = delegate;
        NSString *url = [OpenGDPREndpoints statusUrlWithRequestID:requestID];
        [[HttpRequest alloc] startWithUrlString:url withMethod:@"GET" delegate:self];
    }
}

- (void)invokeDidLoad:(StatusResponseModel *)model
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(success:)]) {
            [self.delegate success:model];
        }
        self.delegate = nil;
    });
}

- (void)invokeDidFail:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.delegate && [self.delegate respondsToSelector:@selector(fail:)]){
            [self.delegate fail:error];
        }
        self.delegate = nil;
    });
}

- (void)processResponseWithData:(NSData *)data
{
    NSError *parseError;
    NSDictionary *jsonDictonary = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&parseError];
    if (parseError) {
        [self invokeDidFail:parseError];
        [Logger error:NSStringFromClass([self class]) withMessage:parseError.localizedDescription];
    } else {
        StatusResponseModel *response = [[StatusResponseModel alloc] initWithDictionary:jsonDictonary];
        [self invokeDidLoad:response];
    }
}

#pragma mark HttpRequestDelegate

- (void)request:(HttpRequest *)request didFinishWithData:(NSData *)data statusCode:(NSInteger)statusCode
{
    [self processResponseWithData:data];
}

- (void)request:(HttpRequest *)request didFailWithError:(NSError *)error
{
    [self invokeDidFail:error];
}

@end
