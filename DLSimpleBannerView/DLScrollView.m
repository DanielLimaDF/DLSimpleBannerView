//
//  DLScrollView.m
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 02/01/17.
//  Copyright © 2017 Daniel Lima. All rights reserved.
//

#import "DLScrollView.h"

@implementation DLScrollView


- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
