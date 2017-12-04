//
//  Encryption.h
//  Aaple Sindhudurg
//
//  Created by Umesh on 01/12/17.
//  Copyright © 2017 SonoraSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key data:(NSData*)data;

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key data:(NSData*)data;

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv data:(NSData*)data;

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv data:(NSData*)data;

@end
