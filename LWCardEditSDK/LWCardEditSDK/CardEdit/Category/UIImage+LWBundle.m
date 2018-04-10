//
//  UIImage+LWBundle.m
//  LWCardEditSDK
//
//  Created by lwmini on 2018/4/4.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "UIImage+LWBundle.h"

@implementation UIImage (LWBundle)
+(UIImage *)imageMyBundleNamed:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:[@"LWCardEdit.bundle" stringByAppendingPathComponent:imageName]];
    if (image) {
        return image;
    } else {
        image = [UIImage imageNamed:[@"Frameworks/LWCardEditSDK.framework/LWCardEdit.bundle" stringByAppendingPathComponent:imageName]];
        if (!image) {
            image = [UIImage imageNamed:imageName];
        }
        return image;
    }
}
@end
