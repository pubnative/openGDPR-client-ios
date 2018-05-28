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

#import "StatusViewController.h"
#import "OpenGDPRStatusClient.h"
#import "Logger.h"

@interface StatusViewController () <OpenGDPRStatusDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation StatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)checkStatus:(UIButton *)sender
{
    [self.textView setText:@" "];
    OpenGDPRStatusClient *client = [[OpenGDPRStatusClient alloc] init];
    [client fetchRequestStatusWithDelegate:self withRequestID:@"a7551968-d5d6-44b2-9831-815ac9017798"];
    [self.loadingIndicator startAnimating];
}

#pragma mark OpenGDPRStatusDelegate

- (void)success:(StatusResponseModel *)model
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
