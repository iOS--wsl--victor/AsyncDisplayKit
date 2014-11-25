//
//  CheapController.m
//  Sample
//
//  Created by Ryan Nystrom on 11/25/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "CheapController.h"

@interface CheapController ()
{
  UILabel *_cheapLabel;
}

@end

@implementation CheapController

- (instancetype)init
{
  if (self = [super init]) {
    _cheapLabel = [[UILabel alloc] init];
    _cheapLabel.text = @"I'm a cheap date.";
    [_cheapLabel sizeToFit];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:_cheapLabel];
}

- (void)viewDidLayoutSubviews
{
  _cheapLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

@end
