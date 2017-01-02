//
//  DLSimpleBannerView.h
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 24/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerImage.h"
#import "DLScrollView.h"

@interface DLSimpleBannerView : UIView<UIScrollViewDelegate, UIGestureRecognizerDelegate, BannerImageDelegate>{
    float totalBanners;
    float startPosition;
    float dragDestination;
    float previewsScreenSize;
    float currentScreenSize;
    BOOL bannerStarted;
    BOOL isDraging;
    BOOL isAnimating;
    CGSize bannerSize;
    BOOL goLeft;
    BOOL goRight;
    BOOL allImagesDownloaded;
    int currentPageNumber;
    NSTimeInterval timeInterval;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *bannerList;
@property (nonatomic, retain) NSMutableArray *myNewList;
@property (nonatomic, retain) NSMutableArray *bannerOffsetPositions;
@property (nonatomic, retain) IBOutlet DLScrollView *myScrollView;

//Gesture Recognizers
@property (nonatomic, retain) UISwipeGestureRecognizer *SwipeLeft;
@property (nonatomic, retain) UISwipeGestureRecognizer *SwipeRight;

-(void)startBanner;
-(void)FillScrollView;
-(void)setBannerSize:(CGSize)size;
-(void)handleSwipeLeft:(UITapGestureRecognizer *)recognizer;
-(void)handleSwipeRight:(UITapGestureRecognizer *)recognizer;
-(void)animationFinished;
-(void)BannerImageFinishedLoading;
-(BOOL)checkImagesDownload;
-(void)showNextBanner;
-(void)setTimeInterval:(NSTimeInterval)interval;

@end
