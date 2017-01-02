//
//  DLSimpleBannerView.m
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 24/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "DLSimpleBannerView.h"

@implementation DLSimpleBannerView
@synthesize bannerList;
@synthesize myScrollView;
@synthesize bannerOffsetPositions;
@synthesize myNewList;
@synthesize SwipeLeft;
@synthesize SwipeRight;
@synthesize timer;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //reset frames
    if(bannerStarted){
        
        //Redefine positions
        
        currentScreenSize = self.frame.size.width;
        
        bannerOffsetPositions = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < [myNewList count]; i++){
            
            float currentPosition = (((bannerSize.width * i) + startPosition) - ((currentScreenSize - previewsScreenSize)/2));
            
            float currentOffsetPosition = currentPosition - startPosition;
            NSNumber *currentOffsetPositionID = [NSNumber numberWithFloat:currentOffsetPosition];
            
            [bannerOffsetPositions addObject:currentOffsetPositionID];
            
        }
        
        float currentPosition = myScrollView.contentOffset.x;
        
        currentPageNumber = round(currentPosition / bannerSize.width);
        
        if(currentPageNumber < 0){
            currentPageNumber = 0;
        }
        if(currentPageNumber >= [myNewList count]){
            currentPageNumber = currentPageNumber = currentPageNumber - 1;
        }
        
        NSNumber *desiredPosition = [bannerOffsetPositions objectAtIndex:currentPageNumber];
        
        dragDestination = [desiredPosition floatValue];
        
        [UIView animateWithDuration:.25 animations:^{
            myScrollView.contentOffset = CGPointMake(dragDestination,  0);
        }
        completion:^(BOOL finished){ [self animationFinished]; }];
        
    }
    
    
}

-(void)startBanner{
    
    if([self checkImagesDownload]){
        allImagesDownloaded = YES;
        [self FillScrollView];
    }
    
}

-(BOOL)checkImagesDownload{
    
    NSInteger totalItens = [bannerList count];
    NSInteger downloadedItens = 0;
    
    for (int i = 0; i < [bannerList count]; i++){
        
        BannerImage *ImageToCheck = [bannerList objectAtIndex:i];
        ImageToCheck.delegate = self;
        
        if([ImageToCheck haveFinishedDownloading]){
            downloadedItens++;
        }
        
    }
    
    NSLog(@"Downloading images %ld / %ld", (long)downloadedItens, (long)totalItens);
    
    if(totalItens == downloadedItens){
        return YES;
    }else{
        return NO;
    }
    
}

-(void)FillScrollView{
    
    currentScreenSize = self.frame.size.width;
    previewsScreenSize = currentScreenSize;
    
    SwipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeLeft:)];
    SwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRight:)];
    
    
    [SwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [SwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self addGestureRecognizer:SwipeLeft];
    [self addGestureRecognizer:SwipeRight];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
        if(bannerSize.width == 0){
            bannerSize.width = 640;
        }
        if(bannerSize.height == 0){
            bannerSize.height = 260;
        }
        
    }else{
        
        if(bannerSize.width == 0){
            bannerSize.width = 320;
        }
        if(bannerSize.height == 0){
            bannerSize.height = 130;
        }
        
    }
    
    //Defaut interval
    if(timeInterval == 0){
        timeInterval = 3;
    }
    
    //Rearrange list
    myNewList = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < ([bannerList count] + 2); i++){
        
        if(i == 0){
            //first
            
            [myNewList addObject:[bannerList objectAtIndex:([bannerList count] - 1)]];
            
        }else{
            if(i == ([bannerList count] + 1)){
                //last
                [myNewList addObject:[bannerList objectAtIndex:0]];
                
            }else{
                
                [myNewList addObject:[bannerList objectAtIndex:i-1]];
                
            }
        }
        
    }
    
    dragDestination = 0;
    
    totalBanners = [myNewList count];
    bannerOffsetPositions = [[NSMutableArray alloc]init];
    
    //Config scrolview
    myScrollView.delegate = self;
    
    [myScrollView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    [myScrollView setClipsToBounds:NO];
    [myScrollView setUserInteractionEnabled:YES];
    [myScrollView setScrollEnabled:YES];
    [myScrollView setPagingEnabled:NO];
    [myScrollView setBounces:YES];
    [myScrollView setScrollsToTop:NO];
    [myScrollView setAlwaysBounceHorizontal:YES];
    [myScrollView setAlwaysBounceVertical:NO];
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    [myScrollView setShowsVerticalScrollIndicator:NO];
    
    //Calc positions
    startPosition = ((self.frame.size.width /2) - (bannerSize.width /2));
    float negativePosition = startPosition - bannerSize.width;
    float positivePosition = (bannerSize.width * totalBanners) + startPosition;
    float scrollContentWidth = (bannerSize.width * totalBanners) + (startPosition * 2);
    
    [myScrollView setContentSize:CGSizeMake(scrollContentWidth, self.frame.size.height)];
    
    //Add images
    for (int i = 0; i < [myNewList count]; i++){
        
        BannerImage *currentBannerImage = [myNewList objectAtIndex:i];
        
        float currentPosition = (bannerSize.width * i) + startPosition;
        float currentOffsetPosition = currentPosition - startPosition;
        NSNumber *currentOffsetPositionID = [NSNumber numberWithFloat:currentOffsetPosition];
        
        UIImageView *currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(currentPosition,0,bannerSize.width,self.frame.size.height)];
        
        [currentImageView setContentMode:[currentBannerImage getContentMode]];
        [currentImageView setImage:currentBannerImage.image];
        
        [myScrollView addSubview:currentImageView];
        [bannerOffsetPositions addObject:currentOffsetPositionID];
        
    }
    
    //Add positive and negative extra images for infinity illusion
    
    BannerImage *positiveBannerImage;
    BannerImage *negativeBannerImage;
    
    negativeBannerImage = [myNewList objectAtIndex:([myNewList count] - 3)];
    positiveBannerImage = [myNewList objectAtIndex:1];
    
    UIImageView *negativeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(negativePosition,0,bannerSize.width,self.frame.size.height)];
    
    UIImageView *positiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(positivePosition,0,bannerSize.width,self.frame.size.height)];
    
    [negativeImageView setContentMode:[negativeBannerImage getContentMode]];
    [positiveImageView setContentMode:[positiveBannerImage getContentMode]];
    
    [negativeImageView setImage:negativeBannerImage.image];
    [positiveImageView setImage:positiveBannerImage.image];
    
    [myScrollView addSubview:negativeImageView];
    [myScrollView addSubview:positiveImageView];
    
    //Position scrollview on the first image
    isAnimating = YES;
    
    NSNumber * initialPosition = [bannerOffsetPositions objectAtIndex:1];
    float initialValue = [initialPosition floatValue];
    [myScrollView setContentOffset:CGPointMake(initialValue, 0) animated: NO];
    
    isDraging = NO;
    isAnimating = NO;
    bannerStarted = YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(showNextBanner) userInfo:nil repeats:YES];
    
}

-(void)setBannerSize:(CGSize)size{
    bannerSize = size;
}
-(void)setTimeInterval:(NSTimeInterval)interval{
    timeInterval = interval;
}


-(void)handleSwipeLeft:(UITapGestureRecognizer *)recognizer{
    
    goLeft = YES;
    
}

-(void)handleSwipeRight:(UITapGestureRecognizer *)recognizer{
    
    goRight = YES;
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(!isAnimating){
        isDraging = YES;
    }
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    //float targatValue = targetContentOffset->x;
    float currentPosition = myScrollView.contentOffset.x;
    
    currentPageNumber = round(currentPosition / bannerSize.width);
    
    if(currentPageNumber < 0){
        currentPageNumber = 0;
    }
    
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    isDraging = NO;
    
    NSNumber *desiredPosition;
    
    if(goLeft){
        //Navigate to Next Page
        int nextPage = currentPageNumber + 1;
        if(nextPage >= [myNewList count]){
            nextPage = currentPageNumber;
        }
        desiredPosition = [bannerOffsetPositions objectAtIndex:nextPage];
        
    }else{
        if(goRight){
            //Navigate to Previous page
            int prevPage = currentPageNumber - 1;
            if(prevPage < 0){
                prevPage = 0;
            }
            desiredPosition = [bannerOffsetPositions objectAtIndex:prevPage];
            
        }else{
            //Navigate to current page
            desiredPosition = [bannerOffsetPositions objectAtIndex:currentPageNumber];
            
        }
    }
    
    goRight = NO;
    goLeft = NO;
    
    dragDestination = [desiredPosition floatValue];
    
    [UIView animateWithDuration:.25 animations:^{
        myScrollView.contentOffset = CGPointMake(dragDestination,  0);
    }
    completion:^(BOOL finished){ [self animationFinished]; }];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(!isDraging && !isAnimating){
        
        CGPoint currentOffset = myScrollView.contentOffset;
        [scrollView setContentOffset:currentOffset animated: NO];
        
        isAnimating = YES;
        
        [UIView animateWithDuration:.25 animations:^{
            myScrollView.contentOffset = CGPointMake(dragDestination,  0);
        }
        completion:^(BOOL finished){ isAnimating = NO; [self animationFinished]; }];
        
    }
    
}

-(void)animationFinished{
    
    //Check current page and change to begin or end of scrollview if necessary
    
    if(!isDraging && !isAnimating){
        
        float currentPosition = myScrollView.contentOffset.x;
        int currentActivePage = round(currentPosition / bannerSize.width);
        
        if(currentActivePage == 0){
            
            isAnimating = YES;
            
            NSNumber * finalPosition = [bannerOffsetPositions objectAtIndex:([myNewList count] -2)];
            float finalValue = [finalPosition floatValue];
            [myScrollView setContentOffset:CGPointMake(finalValue, 0) animated: NO];
            
            isAnimating = NO;
            
        }
        
        if(currentActivePage == ([myNewList count] -1)){
            
            isAnimating = YES;
            
            NSNumber * initialPosition = [bannerOffsetPositions objectAtIndex:1];
            float initialValue = [initialPosition floatValue];
            [myScrollView setContentOffset:CGPointMake(initialValue, 0) animated: NO];
            
            isAnimating = NO;
            
        }
    }
}


-(void)showNextBanner{
    
    NSNumber *desiredPosition;
    
    float currentPosition = myScrollView.contentOffset.x;
    
    currentPageNumber = round(currentPosition / bannerSize.width);
    
    if(currentPageNumber < 0){
        currentPageNumber = 0;
    }
    
    int nextPage = currentPageNumber + 1;
    if(nextPage >= [myNewList count]){
        nextPage = currentPageNumber;
    }
    desiredPosition = [bannerOffsetPositions objectAtIndex:nextPage];
    
    dragDestination = [desiredPosition floatValue];
    
    [UIView animateWithDuration:.25 animations:^{
        myScrollView.contentOffset = CGPointMake(dragDestination,  0);
    }
    completion:^(BOOL finished){ [self animationFinished]; }];
    
    
}

//Banner image delegate
-(void)BannerImageFinishedLoading{
    
    if(!allImagesDownloaded){
        [self startBanner];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
