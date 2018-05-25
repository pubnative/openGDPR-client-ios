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

#import "UrlUtil.h"

@implementation UrlUtil

+ (NSData *)createPOSTBodyFromModel:(OpenGDPRRequestModel *)model
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if (model.subjectRequestID) {
        [dictionary setObject:model.subjectRequestID forKey:@"subject_request_id"];
    }
    if (model.subjectRequestType) {
        [dictionary setObject:model.subjectRequestType forKey:@"subject_request_type"];
    }
    if (model.subjectIdentities) {
        [dictionary setObject:model.subjectIdentities forKey:@"subject_identities"];
    }
    if (model.submittedTime) {
        [dictionary setObject:model.submittedTime forKey:@"submitted_time"];
    }
    if (model.apiVersion) {
        [dictionary setObject:model.apiVersion forKey:@"api_version"];
    }
    if (model.statusCallbackUrls) {
        [dictionary setObject:model.statusCallbackUrls forKey:@"status_callback_urls"];
    }
    if (model.extensions) {
        [dictionary setObject:model.extensions forKey:@"extensions"];
    }

    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return jsonData;
}

@end
