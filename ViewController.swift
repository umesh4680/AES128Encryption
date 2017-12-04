//
//  ViewController.swift
//  AES128Encryption
//
//  Created by Umesh on 04/12/17.
//  Copyright © 2017 Umesh. All rights reserved.
//

import UIKit

struct ConstantString {
    
    struct Encryption {
        
        // WARNING : - Provide your key that is used for Encryption and Decryption from server side.
        
        static let key = "$DmPIsyRB@67CHT#";
        static let normalText = "UMESH";
    }
    
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let encString = self.AES128WithBase64Encoding(inputString: "UMESH")
        print("encString = \(encString)")
        
        
        let decString = self.AES128WithBase64Decoding(inputCipherString: encString)
        print("decString = \(decString)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func AES128WithBase64Encoding(inputString:String) -> String {
        
        let key = ConstantString.Encryption.key
        // let normalText = "UMESH";
        
        var cipherData : Data
        var base64Text : String
        
        cipherData = inputString.data(using: String.Encoding.utf8)!
        
        // Normal Text To AES128 Conversion
        let eobj:Encryption = Encryption()
        cipherData = eobj.aes128EncryptedData(withKey: key, data: cipherData as Data!)
        print("cipherData = \(cipherData)")
        
        //  AES128 -> base64
        // base 64 encryption
        base64Text = (cipherData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) as String)
        
        print("cipherData base 64= \(base64Text)")
        
        return base64Text
    }
    
    
    func AES128WithBase64Decoding(inputCipherString:String) -> String {
        
        let key = ConstantString.Encryption.key
        // let normalText = "UMESH";
        
        var cipherData : Data
        var cipherData1 : Data
        var decreptedString : String
        
        /*
         cipherData = inputCipherString.data(using: String.Encoding.utf8)!
         
         let eobj:Encryption = Encryption()
         cipherData = eobj.aes128DecryptedData(withKey: key, data: cipherData)
         
         decreptedString = String(data: cipherData, encoding: String.Encoding.utf8)
         
         print("Decrypted AES128 and base 64= \(decreptedString)")
         
         */
        
        cipherData = Data(base64Encoded: inputCipherString, options: Data.Base64DecodingOptions(rawValue: NSData.Base64DecodingOptions.RawValue(0)))!
        
        let eobj:Encryption = Encryption()
        cipherData1 = eobj.aes128DecryptedData(withKey: key, data: cipherData)
        
        decreptedString = String(data: cipherData1, encoding: String.Encoding.utf8)!
        
        print("Decrypted AES128 and base 64= \(String(describing: decreptedString))")
        
        return decreptedString
    }
    
    


}

