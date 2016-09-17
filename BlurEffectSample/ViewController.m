//
//  ViewController.m
//  BlurEffectSample
//
//  Created by Avinash Kashyap on 9/16/16.
//  Copyright © 2016 Headerlabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self createGradientLayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
#pragma mark -
-(void) createGradientLayer{
    [self addGrandientlayerToView:self.horizontalLineViewFirst];
    [self addGrandientlayerToView:self.horizontalLineViewSecond];
}
#pragma mark - Add Gradient
-(void) addGrandientlayerToView:(UIView *)gradientView{
    //create a gradient layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //set gradient color
    CGColorRef outerColor = [[UIColor colorWithWhite:0.97 alpha:1.0] CGColor];
    CGColorRef innerColor = [[UIColor colorWithWhite:0.72 alpha:0.0] CGColor];
    //set name of the layer
    gradientLayer.name = @"BlurGradientLayer";
    //set color to gradien layer
    gradientLayer.colors = [NSArray arrayWithObjects:(__bridge id)outerColor,(__bridge id)innerColor,(__bridge id)innerColor,(__bridge id)outerColor, nil];
    //set location to each color
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.200],[NSNumber numberWithFloat:0.710],[NSNumber numberWithFloat:1.0], nil];
    //set start point for draw a gradient layer
    [gradientLayer setStartPoint:CGPointMake(0, 0.6)];
    //set start point for draw a gradient layer
    [gradientLayer setEndPoint:CGPointMake(1, 0.6)];
    //set bound of the layer
    gradientLayer.bounds = gradientView.bounds;
    //set anchor point of layer to {0,0}
    gradientLayer.anchorPoint = CGPointZero;
    [gradientView.layer addSublayer:gradientLayer];
}
#pragma mark -
#pragma mark Handle Orientation
- (void) handleOrientationChange:(NSNotification *)notification{
    [self resetAllGradientLayer];
}
-(void) resetAllGradientLayer{
    [self resetGradientforView:self.horizontalLineViewFirst];
    [self resetGradientforView:self.horizontalLineViewSecond];
}
-(void) resetGradientforView:(UIView *)gradientView{
    for (CAGradientLayer *layer in gradientView.layer.sublayers){
        if ([layer.name isEqualToString:@"BlurGradientLayer"]) {
            layer.bounds = gradientView.bounds;
        }
    }
}
@end
