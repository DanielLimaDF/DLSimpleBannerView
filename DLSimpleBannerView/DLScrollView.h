//
//  DLScrollView.h
//  DLSimpleBannerView
//
//  Created by Daniel Lima on 02/01/17.
//  Copyright © 2017 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLScrollView : UIScrollView{
    
}

- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer *)otherGestureRecognizer;

@end
