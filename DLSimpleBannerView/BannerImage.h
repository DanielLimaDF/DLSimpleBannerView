//
//  BannerImage.h
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 25/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BannerImageDelegate
- (void)BannerImageFinishedLoading;
@end

@interface BannerImage : NSObject{
    id <NSObject, BannerImageDelegate > delegate;
    UIViewContentMode contentMode;
    BOOL alreadyFinishedLoading;
}

@property (nonatomic,retain) UIImage *image;
@property (retain) id <NSObject, BannerImageDelegate > delegate;

-(id)init;
-(void)setLocalImage:(NSString*)imageFileName;
-(void)setUrlImage:(NSString*)imageUrl;

- (UIImage*)loadImage:(NSString *)arquivo;
-(void)saveImage:(UIImage *)img withName:(NSString*)fileName;
-(void)setContentMode:(UIViewContentMode)sentMode;
-(UIViewContentMode)getContentMode;
-(BOOL)haveFinishedDownloading;

@end
