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

#import "Logger.h"

// Default setting is LogLevelNone.

static LogLevel logLevel;

@implementation Logger

+ (void)setLogLevel:(LogLevel)level
{
    NSArray *levelNames = @[
                            @"none",
                            @"error",
                            @"warning",
                            @"info",
                            @"debug",
                            ];
    
    NSString *levelName = levelNames[level];
    NSLog(@"Open GDPR Client Logger: log level set to %@", levelName);
    logLevel = level;
}

+ (void)error:(NSString *)tag withMessage:(NSString *)message
{
    if (logLevel >= LogLevelError) {
        NSLog(@"%@: (E) %@", tag, message);
    }
}

+ (void)warning:(NSString *)tag withMessage:(NSString *)message
{
    if (logLevel >= LogLevelWarning) {
        NSLog(@"%@: (W) %@", tag, message);
    }
}

+ (void)info:(NSString *)tag withMessage:(NSString *)message
{
    if (logLevel >= LogLevelInfo) {
        NSLog(@"%@: (I) %@", tag, message);
    }
}

+ (void)debug:(NSString *)tag withMessage:(NSString *)message
{
    if (logLevel >= LogLevelDebug) {
        NSLog(@"%@: (D) %@", tag, message);
    }
}

@end
