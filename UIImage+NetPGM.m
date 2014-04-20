//
//  UIImage+NetPBM.m
//  UIImage+NetPBM
//
//  Created by Aleksey Garbarev on 20.04.14.
//  Copyright (c) 2014 Aleksey Garbarev. All rights reserved.
//

#import "UIImage+NetPGM.h"

@implementation UIImage (NetPGM)

+ (UIImage *)imageWithPgmName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"pgm"];
    return [self imageFromPgmFilePath:path];
}

+ (UIImage *)imageFromPgmFilePath:(NSString *)path
{
    return [self imageFromPgmData:[NSData dataWithContentsOfFile:path]];
}

+ (UIImage *)imageFromPgmData:(NSData *)data
{
    const char *bytes = [data bytes];
    
    char magicalNumber[2];
    
    memcpy(magicalNumber, bytes, 2);
    
    if (strcmp(magicalNumber, "P5") != 0) {
        NSLog(@"file is not binary PGM! Aborting..");
        return nil;
    }
    
    int imageWidth;
    int imageHeight;
    int location = GetImageSizeFromBytes(bytes, &imageWidth, &imageHeight);
    
    const UInt8 *imageBytes = (UInt8 *) (bytes + location);

    NSAssert([data length] - location == imageWidth * imageHeight, @"Remaining data must cover image size");
    CFDataRef imageData = CFDataCreate(NULL, imageBytes, [data length] - location);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(imageData);
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 8, imageWidth, space, 0, provider, NULL, NO, kCGRenderingIntentDefault);
    
    return [UIImage imageWithCGImage:imageRef];
}

static int GetImageSizeFromBytes(const char *bytes, int *width, int *height)
{
    int location = 0;

    NSMutableString *imageSizeString = [NSMutableString stringWithCapacity:10];
    for (int i = 3; bytes[i] != '\n'; i ++) {
        [imageSizeString appendFormat:@"%c",bytes[i]];
        location = i+2;
    }
    NSScanner *sizedScanner = [NSScanner scannerWithString:imageSizeString];
    [sizedScanner scanInt:width];
    [sizedScanner scanInt:height];

    //Skip unused parameter
    for (int i = location; bytes[i] != '\n'; i ++) {
        location = i+2;
    }
    
    return location;
}

@end
