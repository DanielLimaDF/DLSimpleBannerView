# DLSimpleBannerView

License: MIT

Platform: iOs

##Very simple way to make a banner with similar style to the App Store (Using Storyboard)

DLSimpleBannerView is a UIView Subclass containing a UIScrolView that shows local images or loaded from the web.

####Screenshots:
iPhone<br>
![Alt][screenshot1]

iPad<br>
![Alt][screenshot2]

[screenshot1]: https://github.com/DanielLimaDF/DLSimpleBannerView/blob/master/Screenshots/iPhone_Screen.png
[screenshot2]: https://github.com/DanielLimaDF/DLSimpleBannerView/blob/master/Screenshots/iPad_Screen.png

## Usage

Implementing DLSimpleBannerView is fairly easy, the first step is to set up in Interface Builder:
![Alt][screenshot3]
[screenshot3]: https://github.com/DanielLimaDF/DLSimpleBannerView/blob/master/Screenshots/xcode.png

Coding:

```obj-c

//You can, for example, create a vector of images

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imageList = [[NSMutableArray alloc]init];
    
    BannerImage *img1 = [[BannerImage alloc] init];
    BannerImage *img2 = [[BannerImage alloc] init];
    BannerImage *img3 = [[BannerImage alloc] init];
    BannerImage *img4 = [[BannerImage alloc] init];
    BannerImage *img5 = [[BannerImage alloc] init];
    BannerImage *img6 = [[BannerImage alloc] init];
    
    [img1 setLocalImage:@"yourimagefile1.png"];
    [img2 setLocalImage:@"yourimagefile2.png"];
    [img3 setLocalImage:@"yourimagefile3.png"];
    [img4 setUrlImage:@"http://yoururl.com/yourimagefile4.png"];
    [img5 setUrlImage:@"http://yoururl.com/yourimagefile5.png"];
    [img6 setUrlImage:@"http://yoururl.com/yourimagefile6.png"];
    
    [imageList addObject:img1];
    [imageList addObject:img2];
    [imageList addObject:img3];
    [imageList addObject:img4];
    [imageList addObject:img5];
    [imageList addObject:img6];
    
}

//Start the banner in your viewDidAppear method
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //Size for the banner images -> OPTIONAL
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //iPad
        [bannerView setBannerSize:CGSizeMake(640, 260)];
    }else{
        //iPhone
        [bannerView setBannerSize:CGSizeMake(320, 130)];
    }
    
    
    [bannerView setBannerList:imageList];
    [bannerView setTimeInterval:5];//seconds -> OPTIONAL
    [bannerView startBanner];
    
}


```

I recommend that you download and run the project to better understand how it works.

## License

DLSimpleURLAudioPlayer is available under the MIT license. See the LICENSE file for more info.