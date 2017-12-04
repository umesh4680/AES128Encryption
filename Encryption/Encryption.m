//
//  Encryption.m
//  Aaple Sindhudurg
//
//  Created by Umesh on 01/12/17.
//  Copyright © 2017 SonoraSoftware. All rights reserved.
//

#import "Encryption.h"

#import <CommonCrypto/CommonCryptor.h>

#import "AES128Encryption-Swift.h"


@implementation Encryption


- (NSData *)AES128EncryptedDataWithKey:(NSString *)key data:(NSData*)data
{
    return [self AES128EncryptedDataWithKey:key iv:nil data:(NSData*)data];
}

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key data:(NSData*)data
{
    return [self AES128DecryptedDataWithKey:key iv:nil data:data];
}

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv data:(NSData*)data
{
    return [self AES128Operation:kCCEncrypt key:key iv:iv data:data];
}

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv data:(NSData*)data
{
    return [self AES128Operation:kCCDecrypt key:key iv:iv data:data];
}

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv data:(NSData*)data
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    if (iv) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
    
    
  //  NSData *data;
    
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

/*
-(NSString *)AES128WithBase64Encoding :(NSString*)inputString
{
    NSData *cipherData;
    NSString *base64Text;

    // Normal Text To AES128 Conversion
    cipherData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    cipherData = [ self AES128EncryptedDataWithKey:key data:<#(NSData *)#>];
    
    NSLog(@"Encryptes AES128  %@", cipherData);
    
    //  AES128 -> base64
    // base 64 encryption
    base64Text = [cipherData base64EncodedStringWithOptions:0];
    
    NSLog(@"Encryptes AES128 and base64  %@", base64Text);
    
}

*/



// Use below methods in your Swift class file for Encryption and Decryptions
/*
 
 
 */


@end
