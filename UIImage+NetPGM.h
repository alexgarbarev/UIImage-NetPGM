//
//  UIImage+NetPBM.h
//  UIImage+NetPBM
//
//  Created by Aleksey Garbarev on 20.04.14.
//  Copyright (c) 2014 Aleksey Garbarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NetPGM)

+ (UIImage *)imageWithPgmName:(NSString *)name;
+ (UIImage *)imageFromPgmFilePath:(NSString *)path;
+ (UIImage *)imageFromPgmData:(NSData *)data;

@end
