//
//  UIImageView+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/4/29.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//

#import "UIImageView+Categories.h"

#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIImageView_Categories)

@implementation UIImageView (Categories)

- (UIColor *)averageColorInRect:(CGRect)rect;{

    UIImage *image = [self image] ;
    float red = 0.0,green = 0.0,blue = 0.0,alpha = 0.0;
    int viewHeight = [self frame].size.height;
    int viewWidth = [self frame].size.width ;
    int dstHeight = rect.size.height ;
    int dstWidth = rect.size.width ;

    CGImageRef inImage = image.CGImage;

    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    long             bitmapByteCount;
    long             bitmapBytesPerRow;
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease(colorSpace);

    if (!context) {
        return nil ;
    }
    long imageHeight = CGImageGetHeight(inImage);
    long imageWidth = CGImageGetWidth(inImage);
    long height = imageHeight / viewHeight * dstHeight ;
    long width = imageWidth / viewWidth * dstWidth ;
    CGPoint dstPoint = rect.origin ;

    int x = (int)(dstPoint.x * imageWidth/ viewWidth) ;
    int y = (int)(dstPoint.y * imageHeight / viewHeight) ;
    //int y = (int)((labelPoint.y + labelHeight/2 ) * imageHeight / viewHeight) ;

    CGRect imageRect = {{0,0},{imageHeight,imageWidth}};
    CGContextDrawImage(context, imageRect, inImage);
    unsigned char* data = CGBitmapContextGetData(context);
    for (int i = 0;i<height;i++) {
        int xx = x ;
        //循环遍历
        for (int j = 0; j<width; j++) {
            long offset = 4 * width * y + 4*xx;
            red += (float)data[ offset ];
            green += (float)data[ offset + 1 ];
            blue += (float)data[ offset + 2 ];
            alpha += (float)data[ offset + 3 ];
            xx++;
        }
        y++;
    }

    if (data) free(data);

    CGContextRelease(context);

    red = 1 - ( red/255.0f/( height * width ));
    green = 1 - ( green/255.0f/( height * width ));
    blue = 1 - ( blue/255.0f/( height * width ));
    alpha = alpha/255.0f/( height * width );

    return  [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
