//
//  ViewController.h
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 24/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSimpleBannerView.h"
#import "BannerImage.h"

@interface ViewController : UIViewController{
    
}

@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic, retain) IBOutlet DLSimpleBannerView *bannerView;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *bannerHeight;

@end

