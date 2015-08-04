//
//  ViewController.m
//  RunningLED
//
//  Created by du phung cong on 8/4/15.
//  Copyright (c) 2015 duphungcong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin; // > ball radius
    int _numberOfBall;
    CGFloat _space; // > ball diameter;
    CGFloat _ballDiameter;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _ballDiameter = 24.0;
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    [self drawRowOfBalls:14];
    
}

- (void) placeBallAtX: (CGFloat) x
                andY: (CGFloat) y
             withTag: (int) tag {
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    
    NSLog(@"w = %3.0f, h = %3.0f", ball.bounds.size.width, ball.bounds.size.height);
}

- (void) numberOfBallvsSpace {
    BOOL stop = false;
    int n =3;
    while(!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if(space < _ballDiameter) {
            stop = true;
        }
        else {
            NSLog(@"Number of ball %d, space between ball center %3.0f", n, space);
        }
        n++;
    }
}

- (CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) numberOfBall {
    return (self.view.bounds.size.width - 2 * _margin) / (numberOfBall - 1);
}

- (void) drawRowOfBalls: (int) numberOfBall {
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberOfBall];
    for(int i = 0; i < numberOfBall; i++) {
        [self placeBallAtX:(_margin + i * space)
                      andY:100
                   withTag:(i + 100)];
    }
}

- (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"x= %3.0f, y = %3.0f", size.width, size.height);
}

@end
