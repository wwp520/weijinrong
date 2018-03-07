//
//  CodeLinkController.m
//  weijinrong
//
//  Created by ouda on 2018/3/6.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "CodeLinkController.h"
#import "HomeBtn.h"
#import "ShareLinkController.h"

@interface CodeLinkController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation CodeLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"分享链接";
    self.view.backgroundColor = [UIColor whiteColor];
    
    HomeBtn *homeBtn = [HomeBtn initWithTitle:@"分享" icon:nil];
    UIButton *btn = (UIButton *)homeBtn.customView;
    self.navigationItem.rightBarButtonItem = homeBtn;
    [btn addTarget:self action:@selector(DrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)DrawBtnClick:(UIButton *)btn{
    UIImage * image = [self cutPic];
    
    ShareLinkController * shareVC = [[ShareLinkController alloc]init];
    shareVC.image = image;
    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)setWebUrl:(NSString *)webUrl{
    _webUrl = webUrl;
    [self createWebView];
}
//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];

    NSURL * url = [NSURL URLWithString:self.webUrl];
    NSURLRequest * request = [NSURLRequest  requestWithURL:url];
    [self.webView  loadRequest:request];
}

#pragma mark--截屏处理
//截屏处理
- (UIImage *)cutPic{
    
    CGRect snapshotFrame = CGRectMake(0, 0, _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
    UIEdgeInsets snapshotEdgeInsets = UIEdgeInsetsZero;
    UIImage *shareImage = [self snapshotViewFromRect:snapshotFrame withCapInsets:snapshotEdgeInsets];
    return shareImage;
}


// 网页长截图
- (UIImage *)snapshotViewFromRect:(CGRect)rect withCapInsets:(UIEdgeInsets)capInsets {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize boundsSize = self.webView.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize contentSize = self.webView.scrollView.contentSize;
    CGFloat contentHeight = contentSize.height;
    //    CGFloat contentWidth = contentSize.width;
    
    CGPoint offset = self.webView.scrollView.contentOffset;
    
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0)];
    
    NSMutableArray *images = [NSMutableArray array];
    while (contentHeight > 0) {
        UIGraphicsBeginImageContextWithOptions(boundsSize, NO, [UIScreen mainScreen].scale);
        [self.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [images addObject:image];
        
        CGFloat offsetY = self.webView.scrollView.contentOffset.y;
        [self.webView.scrollView setContentOffset:CGPointMake(0, offsetY + boundsHeight)];
        contentHeight -= boundsHeight;
    }
    
    
    [self.webView.scrollView setContentOffset:offset];
    
    CGSize imageSize = CGSizeMake(contentSize.width * scale,
                                  contentSize.height * scale);
    UIGraphicsBeginImageContext(imageSize);
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        [image drawInRect:CGRectMake(0,
                                     scale * boundsHeight * idx,
                                     scale * boundsWidth,
                                     scale * boundsHeight)];
    }];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * snapshotView = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    
    snapshotView.image = [fullImage resizableImageWithCapInsets:capInsets];
    NSData *data = UIImageJPEGRepresentation(snapshotView.image, 0.3);
    return [UIImage imageWithData:data];
}


@end
