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

#import "RequestViewController.h"
#import "OpenGDPRRequestClient.h"
#import "OpenGDPRRequest.h"
#import "Logger.h"
#import "RequestType.h"
#import "RequestIdentityModel.h"
#import "IdentityType.h"
#import "IdentityFormat.h"
#import "CryptoUtil.h"

@interface RequestViewController () <OpenGDPRRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *accessButton;
@property (weak, nonatomic) IBOutlet UIButton *portabilityButton;
@property (weak, nonatomic) IBOutlet UIButton *erasureButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) NSString *requestType;
@end

@implementation RequestViewController

- (void)dealloc
{
    self.requestType = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)accessTouchUpInside:(UIButton *)sender
{
    self.accessButton.selected = YES;
    self.portabilityButton.selected = NO;
    self.erasureButton.selected = NO;
    [self.accessButton setBackgroundColor:[UIColor colorWithRed:0.33 green:0.59 blue:0.23 alpha:1.00]];
    [self.portabilityButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    [self.erasureButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    self.requestType = [RequestType access];
}

- (IBAction)portabilityTouchUpInside:(UIButton *)sender
{
    self.accessButton.selected = NO;
    self.portabilityButton.selected = YES;
    self.erasureButton.selected = NO;
    [self.accessButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    [self.portabilityButton setBackgroundColor:[UIColor colorWithRed:0.33 green:0.59 blue:0.23 alpha:1.00]];
    [self.erasureButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    self.requestType = [RequestType portability];
}

- (IBAction)erasureTouchUpInside:(UIButton *)sender
{
    self.accessButton.selected = NO;
    self.portabilityButton.selected = NO;
    self.erasureButton.selected = YES;
    [self.accessButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    [self.portabilityButton setBackgroundColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]];
    [self.erasureButton setBackgroundColor:[UIColor colorWithRed:0.33 green:0.59 blue:0.23 alpha:1.00]];
    self.requestType = [RequestType erasure];
}

- (IBAction)request:(UIButton *)sender
{
    [self.textView setText:@" "];
    
    NSString *email = @"test@mail.com";
    
    RequestIdentityModel *identity1 = [[RequestIdentityModel alloc] init];
    identity1.identityType = [IdentityType email];
    identity1.identityFormat = [IdentityFormat raw];
    identity1.identityValue = email;
    
    RequestIdentityModel *identity2 = [[RequestIdentityModel alloc] init];
    identity2.identityType = [IdentityType email];
    identity2.identityFormat = [IdentityFormat md5];
    identity2.identityValue = [CryptoUtil md5WithString:email];
    
    RequestIdentityModel *identity3 = [[RequestIdentityModel alloc] init];
    identity3.identityType = [IdentityType email];
    identity3.identityFormat = [IdentityFormat sha1];
    identity3.identityValue = [CryptoUtil sha1WithString:email];
    
    RequestIdentityModel *identity4 = [[RequestIdentityModel alloc] init];
    identity4.identityType = [IdentityType email];
    identity4.identityFormat = [IdentityFormat sha256];
    identity4.identityValue = [CryptoUtil sha256WithString:email];
    
    OpenGDPRRequest *request = [[OpenGDPRRequest alloc] init];
    [request addIdentity:identity1];
    [request addIdentity:identity2];
    [request setType:self.requestType];
    
    OpenGDPRRequestClient *client = [[OpenGDPRRequestClient alloc] init];
    [client doRequestWithDelegate:self withRequest:request];
    [self.loadingIndicator startAnimating];
}

#pragma mark OpenGDPRRequestDelegate

- (void)success:(OpenGDPRResponseModel *)model
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
