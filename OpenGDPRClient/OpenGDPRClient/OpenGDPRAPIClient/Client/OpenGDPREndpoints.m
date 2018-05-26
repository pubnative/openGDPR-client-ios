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

#import "OpenGDPREndpoints.h"

NSString *const kScheme = @"https://";
NSString *const kBaseUrl = @"opengdpr-api.herokuapp.com/";
NSString *const kAPIPath = @"api/";
NSString *const kAPIVersion = @"1.0";
NSString *const kDiscovery = @"/discovery";
NSString *const kRequests = @"/opengdpr_requests";

@implementation OpenGDPREndpoints

+ (NSString *)apiVersion
{
    return kAPIVersion;
}

+ (NSString *)discoveryEndpoint
{
    NSString *urlString = [[NSString alloc] init];
    urlString = [urlString stringByAppendingString:kScheme];
    urlString = [urlString stringByAppendingString:kBaseUrl];
    urlString = [urlString stringByAppendingString:kAPIPath];
    urlString = [urlString stringByAppendingString:kAPIVersion];
    urlString = [urlString stringByAppendingString:kDiscovery];
    return urlString;
}

+ (NSString *)requestEndpoint
{
    NSString *urlString = [[NSString alloc] init];
    urlString = [urlString stringByAppendingString:kScheme];
    urlString = [urlString stringByAppendingString:kBaseUrl];
    urlString = [urlString stringByAppendingString:kAPIPath];
    urlString = [urlString stringByAppendingString:kAPIVersion];
    urlString = [urlString stringByAppendingString:kRequests];
    return urlString;
}

+ (NSString *)statusUrlWithRequestID:(NSString *)requestID
{
    NSString *urlString = [[NSString alloc] init];
    urlString = [urlString stringByAppendingString:kScheme];
    urlString = [urlString stringByAppendingString:kBaseUrl];
    urlString = [urlString stringByAppendingString:kAPIPath];
    urlString = [urlString stringByAppendingString:kAPIVersion];
    urlString = [urlString stringByAppendingString:kRequests];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/%@",requestID]];
    return urlString;
}

+ (NSString *)cancellationEndpointWithRequestID:(NSString *)requestID
{
    NSString *urlString = [[NSString alloc] init];
    urlString = [urlString stringByAppendingString:kScheme];
    urlString = [urlString stringByAppendingString:kBaseUrl];
    urlString = [urlString stringByAppendingString:kAPIPath];
    urlString = [urlString stringByAppendingString:kAPIVersion];
    urlString = [urlString stringByAppendingString:kRequests];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/%@",requestID]];
    return urlString;
}

@end
