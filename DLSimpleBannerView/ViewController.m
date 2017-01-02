//
//  ViewController.m
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 24/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize bannerView;
@synthesize imageList;
@synthesize bannerHeight;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imageList = [[NSMutableArray alloc]init];
    
    BannerImage *img1 = [[BannerImage alloc] init];
    BannerImage *img2 = [[BannerImage alloc] init];
    BannerImage *img3 = [[BannerImage alloc] init];
    BannerImage *img4 = [[BannerImage alloc] init];
    BannerImage *img5 = [[BannerImage alloc] init];
    BannerImage *img6 = [[BannerImage alloc] init];
    
    [img1 setLocalImage:@"banner1.png"];
    [img2 setLocalImage:@"banner2.png"];
    [img3 setLocalImage:@"banner3.png"];
    [img4 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/banner4.png"];
    [img5 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/banner5.png"];
    [img6 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/banner6.png"];
    
    [imageList addObject:img1];
    [imageList addObject:img2];
    [imageList addObject:img3];
    [imageList addObject:img4];
    [imageList addObject:img5];
    [imageList addObject:img6];
    
    //Banner Height
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [bannerHeight setConstant:260.00];
    }else{
        [bannerHeight setConstant:130.00];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //[bannerView setBannerSize:CGSizeMake(420, 430)]; //Optional
    
    [bannerView setBannerList:imageList];
    [bannerView setTimeInterval:5];//seconds
    [bannerView startBanner];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
