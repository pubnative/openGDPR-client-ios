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

#import "CancellationViewController.h"
#import "OpenGDPRCancellationClient.h"
#import "Logger.h"

@interface CancellationViewController () <OpenGDPRCancellationDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation CancellationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)cancelRequest:(UIButton *)sender
{
    [self.textView setText:@" "];
    OpenGDPRCancellationClient *client = [[OpenGDPRCancellationClient alloc] init];
    [client doCancellationRequestWithDelegate:self withRequestID:@"a7551968-d5d6-44b2-9831-815ac9017798"];
    [self.loadingIndicator startAnimating];
}

#pragma mark OpenGDPRCancellationDelegate

- (void)success:(CancellationResponseModel *)model
{
    [self.textView setText:[NSString stringWithFormat:@"%@",model.dictionary]];
    [self.loadingIndicator stopAnimating];
}

- (void)fail:(NSError *)error
{
    [Logger error:NSStringFromClass([self class]) withMessage:error.localizedDescription];
    [self.loadingIndicator stopAnimating];
}

@end
