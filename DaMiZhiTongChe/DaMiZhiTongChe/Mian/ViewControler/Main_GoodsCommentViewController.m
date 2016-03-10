//
//  Main_GoodsCommentViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_GoodsCommentViewController.h"

@interface Main_GoodsCommentViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end

@implementation Main_GoodsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"商品评价";
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 200.0)];
    self.imageView1.userInteractionEnabled = YES;
    self.imageView1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 200.0, SCREEN_WIDTH/2, 100.0)];
    self.imageView2.tag = 0;
    self.imageView2.userInteractionEnabled = YES;
    self.imageView2.backgroundColor = [UIColor redColor];
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panWasRecognized:)];
    [self.panRecognizer setMinimumNumberOfTouches:1];
    [self.panRecognizer setMaximumNumberOfTouches:1];
    [self.imageView2 addGestureRecognizer:self.panRecognizer];
    [self.view addSubview:self.imageView2];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) panWasRecognized:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:recognizer.view.superview];
    CGPoint center = recognizer.view.center;
    center.x += translation.x;
    center.y += translation.y;
    recognizer.view.center = center;
    [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
    if (recognizer.view.tag == 0) {
        if (recognizer.view.center.y < 100.0) {
            recognizer.view.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 200.0);
            if (recognizer.view == self.imageView1) {
                self.imageView2.frame = CGRectMake(0.0, 200.0, SCREEN_WIDTH/2, 100.0);
                self.imageView2.tag = 0;
                [self.view bringSubviewToFront:self.imageView2];
                [self.imageView1 removeGestureRecognizer:recognizer];
                self.imageView1.tag = 1;
                [self performSelector:@selector(setGView:) withObject:self.imageView2 afterDelay:1.0];
            }else if (recognizer.view == self.imageView2){
                self.imageView1.frame = CGRectMake(0.0, 200.0, SCREEN_WIDTH/2, 100.0);
                self.imageView1.tag = 0;
                [self.view bringSubviewToFront:self.imageView1];
                [self.imageView2 removeGestureRecognizer:recognizer];
                self.imageView2.tag = 1;
                [self performSelector:@selector(setGView:) withObject:self.imageView1 afterDelay:.8];
            }
        }
    }
}

- (void) setGView : (UIView *) view {
    [view addGestureRecognizer:self.panRecognizer];
}

@end
