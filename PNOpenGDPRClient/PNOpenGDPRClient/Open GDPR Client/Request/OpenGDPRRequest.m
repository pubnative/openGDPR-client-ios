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

#import <AdSupport/AdSupport.h>
#import "OpenGDPRRequest.h"
#import "RequestType.h"
#import "OpenGDPREndpoints.h"

@implementation OpenGDPRRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestModel = [[OpenGDPRRequestModel alloc] init];
        self.requestModel.subjectRequestID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        self.requestModel.apiVersion = [OpenGDPREndpoints apiVersion];
    }
    return self;
}

- (void)setType:(NSString *)type
{
    if ([type isEqualToString:RequestType.access] || [type isEqualToString:RequestType.portability] || [type isEqualToString:RequestType.erasure] ) {
        self.requestModel.subjectRequestType = type;
    }
}

- (void)setRequestID:(NSString *)requestID
{
    if (requestID.length >0) {
        self.requestModel.subjectRequestID = requestID;
    }
}

- (void)setSubmittedTime:(NSString *)submittedTime
{
    if (submittedTime.length >0) {
        self.requestModel.submittedTime = submittedTime;
    }
}

- (void)addIdentity:(RequestIdentityModel *)identity
{
    if (identity) {
        [self.requestModel.subjectIdentities addObject:identity];
    }
}

- (void)setExtensions:(NSString *)extensions
{
    if (extensions.length >0) {
        self.requestModel.extensions = extensions;
    }
}

- (void)addCallbackUrl:(NSString *)url
{
    if (url.length >0 && ![self.requestModel.statusCallbackUrls containsObject:url]) {
        [self.requestModel.statusCallbackUrls addObject:url];
    }
}
@end
