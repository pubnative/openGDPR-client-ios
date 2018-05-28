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

import UIKit

class RequestViewController: UIViewController
{
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var accessButton: UIButton!
    @IBOutlet weak var portabilityButton: UIButton!
    @IBOutlet weak var erasureButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var requestType : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func accessTouchUpInside(_ sender: UIButton)
    {
        accessButton.isSelected = true
        portabilityButton.isSelected = false
        erasureButton.isSelected = false
        accessButton.backgroundColor = UIColor(red: 0.33, green: 0.59, blue: 0.23, alpha: 1.00)
        portabilityButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        erasureButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        requestType = RequestType.access()
    }
    
    @IBAction func portabilityTouchUpInside(_ sender: UIButton)
    {
        accessButton.isSelected = false
        portabilityButton.isSelected = true
        erasureButton.isSelected = false
        accessButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        portabilityButton.backgroundColor = UIColor(red: 0.33, green: 0.59, blue: 0.23, alpha: 1.00)
        erasureButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        requestType = RequestType.portability()
    }
    
    @IBAction func erasureTouchUpInside(_ sender: UIButton)
    {
        accessButton.isSelected = false
        portabilityButton.isSelected = false
        erasureButton.isSelected = true
        accessButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        portabilityButton.backgroundColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)
        erasureButton.backgroundColor = UIColor(red: 0.33, green: 0.59, blue: 0.23, alpha: 1.00)
        requestType = RequestType.erasure()
    }
    
    @IBAction func request(_ sender: UIButton)
    {
        textView.text = " "

        let email = "test@mail.com"
        
        let identity1 = RequestIdentityModel()
        identity1.identityType = IdentityType.email()
        identity1.identityFormat = IdentityFormat.raw()
        identity1.identityValue = email
        
        let identity2 = RequestIdentityModel()
        identity2.identityType = IdentityType.email()
        identity2.identityFormat = IdentityFormat.md5()
        identity2.identityValue = CryptoUtil.md5(with: email)
        
        let identity3 = RequestIdentityModel()
        identity3.identityType = IdentityType.email()
        identity3.identityFormat = IdentityFormat.sha1()
        identity3.identityValue = CryptoUtil.sha1(with: email)
        
        let identity4 = RequestIdentityModel()
        identity4.identityType = IdentityType.email()
        identity4.identityFormat = IdentityFormat.sha256()
        identity4.identityValue = CryptoUtil.sha256(with: email)
        
        let request = OpenGDPRRequest()
        request.addIdentity(identity1)
        request.addIdentity(identity2)
        request.setType(requestType)
        // Optional
        // request.setRequestID("YOUR UUID HERE")
        let client = OpenGDPRRequestClient()
        client.doRequest(with: self, with: request)
        loadingIndicator.startAnimating()
    }
}

extension RequestViewController : OpenGDPRRequestDelegate
{
    func success(_ model: OpenGDPRResponseModel!)
    {
        textView.text = "\(model.dictionary)"
        loadingIndicator.stopAnimating()
    }

    func fail(_ error: Error!)
    {
        Logger.error(String(describing: type(of: self)), withMessage: error.localizedDescription)
        loadingIndicator.stopAnimating()
    }
}
