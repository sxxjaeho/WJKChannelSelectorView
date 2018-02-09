//
//  UIImage+Extended.m
//  XLFCommonKit
//
//  Created by Marike Jave on 13-6-10.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UIImage+Categories.h"
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIImage_Categories)

@implementation UIImage (Extended)

// 将UIImage缩放到指定大小尺寸：
- (UIImage *)scaleToSize:(CGSize)size{
    return [self scaleToSize:size stretch:YES];
}

- (UIImage *)scaleToSize:(CGSize)size stretch:(BOOL)stretch{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    if (!stretch) {
        CGFloat vScale = size.height/[self size].height;
        CGFloat hScale = size.width/[self size].width;
        // 垂直放大 水平放大 幅度大优先
        if ((vScale > 1 && hScale > 1 && (vScale - 1) > (hScale - 1)) ||
            // 垂直放大 水平缩小 放大优先
            (vScale > 1 && hScale < 1) ||
            // 垂直缩小 水平缩小 幅度小优先
            (vScale < 1 && hScale < 1 && fabs(vScale - 1) < fabs(hScale - 1))) {
            CGFloat width = [self size].width * vScale;
            rect.origin.x = -(width - size.width) / 2.;
            rect.size.width = width;
        } else {
            CGFloat height = [self size].height * hScale;
            rect.origin.y = -(height - size.height) / 2.;
            rect.size.height = height;
        }
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [self scale]);
    [self drawInRect:rect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)subImage:(CGRect)rect{
    CGFloat scale=[self scale];
    // 起点在图片外，直接返回nil
    if (rect.origin.x > self.size.width - 1 || rect.origin.y > self.size.height - 1) {
        return nil;
    }
    // 图片的宽度超出限制的处理
    if (rect.origin.x + rect.size.width > self.size.width) {
        rect.size.width = self.size.width - rect.origin.x;
    }
    // 图片的高度超出限制的处理
    if (rect.origin.y + rect.size.height > self.size.height) {
        rect.size.height = self.size.height - rect.origin.y;
    }
    rect.origin.x*=scale;
    rect.origin.y*=scale;
    rect.size.width*=scale;
    rect.size.height*=scale;
    CGImageRef imageRef=self.CGImage;
    CGImageRef subImageRef=CGImageCreateWithImageInRect(imageRef, rect);
    CGSize size=CGSizeMake(rect.size.width, rect.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage *result=[UIImage imageWithCGImage:subImageRef scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)mergeImage:(UIImage *)backgroundImgae point:(CGPoint)point frontImage:(UIImage *)frontImage{
    UIGraphicsBeginImageContext([backgroundImgae size]);
    [backgroundImgae drawAtPoint:CGPointMake(0,0)];
    [frontImage drawAtPoint:CGPointMake(0,0)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)mergeImageWithPoint:(CGPoint)point image:(UIImage *)image{
    if ([self scale] != [image scale]) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions([self size], NO, [self scale]);
    [self drawAtPoint:CGPointMake(0, 0)];
    [image drawAtPoint:point];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)mergeImageWithFrame:(CGRect)frame image:(UIImage *)image{
    if ([image size].width != frame.size.width || [image size].height != frame.size.height) {
        image = [image scaleToSize:frame.size];
    }
    UIImage *result = [self mergeImageWithPoint:frame.origin image:image];
    return result;
}

+ (UIImage *)superposition:(UIImage *)image withInsets:(UIEdgeInsets)insets andShadowImage:(UIImage *)shadowImage{
    CGSize size = image.size;
    if (size.width<shadowImage.size.width) {
        size.width=shadowImage.size.width;
    }
    if (size.height<shadowImage.size.height) {
        size.height=shadowImage.size.height;
    }
    if (!CGSizeEqualToSize(image.size,size)) {
        image=[image scaleToSize:size];
    }
    if (!CGSizeEqualToSize(shadowImage.size,size)) {
        shadowImage=[shadowImage scaleToSize:size];
    }
    image = [image mergeImageWithPoint:CGPointMake(0, 0) image:shadowImage];
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIImage *)imageFromLabel:(UILabel *)label{
    UIImage *image=[self imageWithSize:label.frame.size color:[UIColor clearColor]];
    return [image mergeImageWithLabel:label inRect:CGRectMake(0, 0, image.size.width, image.size.height)];
}

- (UIImage *)mergeImageWithLabel:(UILabel *)label inRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions([self size], NO, [self scale]);
    [self drawAtPoint:CGPointMake(0, 0)];
    [label drawTextInRect:rect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)mergeImageWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font inRect:(CGRect)rect{

    UIGraphicsBeginImageContextWithOptions([self size], NO, [self scale]);
    [self drawAtPoint:CGPointMake(0, 0)];
    NSInteger rgbaColor=[[self class] RGBAFromColor:color];
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), ((rgbaColor>>24)&0xff)/255.0f, ((rgbaColor>>16)&0xff)/255.0f, ((rgbaColor>>8)&0xff)/255.0f, ((rgbaColor)&0xff)/255.0f);
    [text drawAtPoint:rect.origin withFont:font];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (NSInteger)RGBAFromColor:(UIColor *)color{
    NSString *rgbString=[NSString stringWithFormat:@"%@",color];
    NSArray *rgbArray=[rgbString componentsSeparatedByString:@" "];
    NSInteger r=round([[rgbArray objectAtIndex:1] integerValue]*255);
    NSInteger g=round([[rgbArray objectAtIndex:2] integerValue]*255);
    NSInteger b=round([[rgbArray objectAtIndex:3] integerValue]*255);
    NSInteger a=round([[rgbArray objectAtIndex:4] integerValue]*255);

    return ((r * 256 + g) * 256 + b) * 256 + a;;
}
+ (UIImage *)mergeImageWithSize:(CGSize)size point1:(CGPoint)point1 image1:(UIImage *)image1 point2:(CGPoint)point2 image2:(UIImage *)image2{
    if ([image1 scale] != [image2 scale]) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [image1 scale]);
    [image1 drawAtPoint:point1];
    [image2 drawAtPoint:point2];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)mergeImageWithSize:(CGSize)size frame1:(CGRect)frame1 image1:(UIImage *)image1 frame2:(CGRect)frame2 image2:(UIImage *)image2{
    if ([image1 size].width!=frame1.size.width||[image1 size].height!=frame1.size.height) {
        image1 = [image1 scaleToSize:frame1.size];
    }
    if ([image2 size].width!=frame2.size.width||[image2 size].height!=frame2.size.height) {
        image2 = [image2 scaleToSize:frame2.size];
    }
    return [self mergeImageWithSize:size point1:frame1.origin image1:image1 point2:frame2.origin image2:image2];
}

+ (UIImage *)mergeImageWithSize:(CGSize)size frame1:(CGRect)frame1 image1File:(NSString *)image1File frame2:(CGRect)frame2 image2File:(NSString *)image2File{
    UIImage *image1=[UIImage imageWithContentsOfFile:image1File];
    UIImage *image2=[UIImage imageWithContentsOfFile:image2File];
    return [self mergeImageWithSize:size frame1:frame1 image1:image1 frame2:frame2 image2:image2];
}

+ (UIImage *)imageWithSize:(CGSize)imageSize color:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithImageFilePath:(NSString *)imageFilePath inset:(UIEdgeInsets)insets{
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    return [self image:image inset:insets];
}

+ (UIImage *)image:(UIImage *)image inset:(UIEdgeInsets)insets{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        return [image resizableImageWithCapInsets:insets];
    } else if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        return [image stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
    }
    return image;
}

+ (UIImage*)imageWithImageName:(NSString*)imageName insets:(UIEdgeInsets)insets{
    if (!imageName) {
        return nil;
    }
    return [self image:[UIImage imageNamed:imageName] inset:insets];
}

+ (UIImage*)imageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)bundleImageName:(NSString *)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]];

    return [[UIImage alloc] initWithContentsOfFile:path] ;
}

- (UIImage*)cutImageWithRadius:(int)radius{
    UIGraphicsBeginImageContext([self size]);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    float x1 = 0.;
    float y1 = 0.;
    float x2 = x1 + self.size.width;
    float y2 = y1;
    float x3 = x2;
    float y3 = y1 + self.size.height;
    float x4 = x1;
    float y4 = y3;
    radius = radius * 2;
    CGContextMoveToPoint(gc, x1, y1+radius);
    CGContextAddArcToPoint(gc, x1, y1, x1+radius, y1, radius);
    CGContextAddArcToPoint(gc, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(gc, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(gc, x4, y4, x4, y4-radius, radius);
    CGContextClosePath(gc);
    CGContextClip(gc);
    CGContextTranslateCTM(gc, 0, self.size.height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)screenImage;{
    return [self screenImageInRect:[[UIScreen mainScreen] bounds]];
}

+ (UIImage *)screenImageInRect:(CGRect)rect;{
    UIView *contentView = [[[UIApplication sharedApplication] delegate] window];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (!CGRectEqualToRect(screenRect, rect) && !CGRectContainsRect(screenRect, rect)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    if ([contentView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [contentView drawViewHierarchyInRect:CGRectMake(-rect.origin.x, -rect.origin.y, screenRect.size.width, screenRect.size.height) afterScreenUpdates:NO];
    } else {
        [[contentView layer] renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    return image;
}

+ (UIImage *)screenDefaultBlurImage{
    return [self screenDefaultBlurImageInRect:[[UIScreen mainScreen] bounds]];
}

+ (UIImage *)screenDefaultBlurImageInRect:(CGRect)rect;{
    UIImage *image = [self screenImageInRect:rect];
    return [image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyLightEffect{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    } else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            } else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)videoThumbImage:(NSString *)videoUrl;{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoUrl] options:nil];
    if (!asset) {
        return nil;
    }
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    if (!gen) {
        return nil;
    }
    [gen setAppliesPreferredTrackTransform:YES];
    CMTime time = CMTimeMakeWithSeconds(5.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (!image) {
        return nil;
    }
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

+ (UIImage *)audioThumbImage:(NSString *)songUrl;{
    AudioFileID etFileId = nil;
    OSStatus etError = noErr;
    etError = AudioFileOpenURL( (__bridge CFURLRef)[NSURL URLWithString:songUrl], kAudioFileReadPermission, 0, &etFileId );
    if( etError != noErr ) {
        NSLog( @"AudioFileOpenURL failed" );
        return nil;
    }
    UInt32 etId3DataSize = 0;
    etError = AudioFileGetPropertyInfo( etFileId, kAudioFilePropertyID3Tag, &etId3DataSize, NULL );
    if( etError != noErr ) {
        NSLog( @"AudioFileGetPropertyInfo failed for ID3 tag" );
        return nil;
    }
    NSDictionary *etOutPropertyData = nil;
    UInt32 etIoDataSize = sizeof( etOutPropertyData );
    etError = AudioFileGetProperty( etFileId, kAudioFilePropertyInfoDictionary, &etIoDataSize, &etOutPropertyData );
    if( etError != noErr ) {
        NSLog( @"AudioFileGetProperty failed for property info dictionary" );
        return nil;
    }
    CFDataRef AlbumPic= nil;
    UInt32 picDataSize = sizeof(picDataSize);
    etError =AudioFileGetProperty( etFileId, kAudioFilePropertyAlbumArtwork, &picDataSize, &AlbumPic);
    if( etError != noErr || !AlbumPic) {
        NSLog( @"Get picture failed" );
        return nil;
    }
    UIImage *etImage = [[UIImage alloc]initWithData:(__bridge NSData*)AlbumPic];
    CFRelease(AlbumPic);
    return etImage;
}

- (UIImage *)centerImageInRect:(CGRect)rect{
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)scaleImagetoMaxPix:(CGFloat)maxPix{
    CGFloat widthFactor = maxPix / self.size.width;
    CGFloat heightFactor = maxPix / self.size.height;
    CGFloat scaleFactor = widthFactor > heightFactor ? heightFactor : widthFactor;
    CGSize scaleSize = CGSizeMake(self.size.width * scaleFactor, self.size.height * scaleFactor);
    UIGraphicsBeginImageContext(scaleSize);
    [self drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)combineImageWithImages:(NSArray*)images ;{
    UIImage *resultImgae = nil ;
    CGFloat totalHeight = 0.0f ;
    CGFloat totalWidth = 600.0f ;
    CGFloat imageWidth = 580.0f ;
    CGFloat curHeight = 0.0f ;
    CGFloat backgauge = 10.f ;
    for (UIImage* image in images) {
        totalHeight +=( [image size].height / [image size].width * imageWidth + backgauge ) ;
    }
    if (totalHeight) {
        totalHeight += backgauge ;
        CGRect rect=CGRectMake(0.0f, 0.0f, totalWidth, totalHeight);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor( context, [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor]);
        CGContextFillRect( context, rect);
        for (UIImage* image in images) {
            CGFloat height = [image size].height / [image size].width * totalWidth ;
            curHeight += backgauge ;
            [image drawInRect:CGRectMake( backgauge, curHeight, imageWidth, height )];
            CGContextSetFillColorWithColor( context, [[UIColor clearColor] CGColor]);
            CGContextSetStrokeColorWithColor( context , [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6] CGColor] ) ;
            CGContextSetLineWidth( context , 2.f ) ;
            CGContextAddRect(context ,CGRectMake( backgauge, curHeight, imageWidth, height ) ) ;
            curHeight += height;
        }
    }
    resultImgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImgae ;
}

- (UIImage*)cutImageWithSize:(CGSize)size;{
    UIImage *resultImage = nil ;
    CGFloat left = 0.0f ;
    CGFloat top = 0.0f ;
    CGFloat width = 0.0f ;
    CGFloat height = 0.0f ;
    CGPoint center ;
    CGFloat scale = size.height / size.width ;
    if ([self size].height > [self size].width ) {
        width = [self size].width ;
        height = width * scale ;
    } else {
        height = [self size].height ;
        width = height / scale ;
    }
    center = CGPointMake( [self size].width / 2, [self size].height / 2 ) ;
    left = center.x - width / 2 ;
    top = center.y - height / 2 ;
    if (CGSizeEqualToSize(size, CGSizeMake(width, height))) {
        return self ;
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage , CGRectMake(left, top, width, height)) ;
    resultImage = [UIImage imageWithCGImage:imageRef] ;
    CGImageRelease(imageRef) ;
    return resultImage ;
}

- (UIImage*)scaleImageWithSize:(CGSize)size ;{
    CGSize imageSize = [self size ] ;
    CGFloat scale = imageSize.height/ imageSize.width ;
    CGFloat zoomScale = MIN(size.height/imageSize.height , size.width / imageSize.width ) ;
    CGFloat width = zoomScale * imageSize.width ;
    CGFloat height = width * scale ;
    if ( CGSizeEqualToSize(size, CGSizeMake(width, height))) {
        return self ;
    }
    return [self stretchableImageWithLeftCapWidth:width topCapHeight:height ] ;
}

- (UIImage*)createThumbWithSize:(CGSize )thumbSize {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    } else if (widthFactor < heightFactor) {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [self drawInRect:thumbRect];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage ;
}

+ (UIImage *)imageWithString:(NSString *)string
                        font:(UIFont *)font
                        size:(CGSize)size      
{
    UIGraphicsBeginImageContext(size);
    
    CGSize stringSize = [string sizeWithAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    CGFloat xRatio = size.width / stringSize.width;
    CGFloat yRatio = size.height / stringSize.height;
    CGFloat ratio = MIN(xRatio, yRatio);
    
    CGFloat oldFontSize = font.pointSize;
    CGFloat newFontSize = floor(oldFontSize * ratio);
    ratio = newFontSize / oldFontSize;
    font = [font fontWithSize:newFontSize];
    
    stringSize = [string sizeWithAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    CGPoint textOrigin = CGPointMake((size.width - stringSize.width),(size.height - stringSize.height));
    
    [string drawAtPoint:textOrigin withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
  
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}

@end
