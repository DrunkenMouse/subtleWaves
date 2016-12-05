//
//  ViewController.m
//  若隐若现的电波
//
//  Created by 王奥东 on 16/12/5.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ViewLayer.h"

#define kMaxRadius 160

@interface ViewController ()

@end

@implementation ViewController {
    
    ViewLayer *_haloLayer;
    
    IBOutlet UIImageView *_imgView;
    
    IBOutlet UISlider *_radius;
    
    IBOutlet UISlider *_rSlider;
    
    IBOutlet UISlider *_gSlider;
    
    IBOutlet UISlider *_bSlider;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _haloLayer = [ViewLayer layer];
    _haloLayer.position = CGPointMake(_imgView.center.x+1, _imgView.center.y-70);
    [self.view.layer insertSublayer:_haloLayer above:_imgView.layer];
    
    [self setupFirst];
}

-(void)setupFirst {
    
    _radius.value = 0.5;
    [self radiusChanged:nil];
    
    _rSlider.value = 0;
    _gSlider.value = 0.487;
    _bSlider.value = 1.0;
    [self colorChanged:nil];
}

- (IBAction)radiusChanged:(id)sender {
    
    _haloLayer.radius = _radius.value * kMaxRadius;
}

- (IBAction)colorChanged:(id)sender {
    
    UIColor *color = [UIColor colorWithRed:_rSlider.value green:_gSlider.value blue:_bSlider.value alpha:1.0];
    _haloLayer.backgroundColor = color.CGColor;
    
}




@end
