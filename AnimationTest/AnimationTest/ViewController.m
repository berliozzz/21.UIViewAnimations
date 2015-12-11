//
//  ViewController.m
//  AnimationTest
//
//  Created by Nikolay Berlioz on 01.11.15.
//  Copyright © 2015 Nikolay Berlioz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *testView;

@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImage *image1 =[UIImage imageNamed:@"1.png"];
    UIImage *image2 =[UIImage imageNamed:@"2.png"];
    UIImage *image3 =[UIImage imageNamed:@"3.png"];
    
    NSArray *arrayImages = [[NSArray alloc] initWithObjects:image1, image2, image1, image3, nil];
    
    view.animationImages = arrayImages;
    view.animationDuration = 1.f;
    [view startAnimating];
    
    [self.view addSubview:view];
    
    self.imageView = view; //Our view will see to the all code
}

- (UIColor*) randomColor
{
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void) moveView:(UIView*) view
{
    
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);

    CGFloat s = (float)(arc4random() % 151) / 100 + 0.5f;
    
    CGFloat r = (double)(arc4random() % (int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    
    CGFloat d = (float)(arc4random() % 20001) / 10000 + 2;
    
    [UIView animateWithDuration:d
                          delay:0
                        options:UIViewAnimationOptionCurveLinear /*| UIViewAnimationOptionRepeat |  UIViewAnimationOptionAutoreverse*/
                     animations:^{  //this is animation code
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [self randomColor];
                         
                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
                         
                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         
                         view.transform = transform;
                         
                     }
                     completion:^(BOOL finished) { // it's code launch post animation
                         NSLog(@"animation is finished %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
                         
                         __weak UIView *v = view;
                         [self moveView:v];
                         
                         
                     }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /*
    [UIView animateWithDuration:2.f
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
                     }];
     */
    
    [self moveView:self.imageView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
