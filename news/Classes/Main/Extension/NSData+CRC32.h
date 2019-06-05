//
//  NSData+CRC32.h
//  CRC32_iOS
//
//  Created by 杨蒙 on 2017/12/12.
//  Copyright © 2017年 hrscy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <zlib.h>

@interface NSData (CRC32)

-(int32_t)crc_32;

-(uLong)getCRC32;

@end
