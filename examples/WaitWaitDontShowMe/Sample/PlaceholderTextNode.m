//
//  PlaceholderTextNode.m
//  Sample
//
//  Created by Ryan Nystrom on 11/21/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "PlaceholderTextNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@interface PlaceholderTextNode ()
{
  CALayer *_placeholderLayer;
  BOOL _displayFinished;
}

@end

@implementation PlaceholderTextNode

- (instancetype)init
{
  if (!(self = [super init]))
    return nil;

  _placeholderLayer = [CALayer layer];
  _placeholderLayer.backgroundColor = [UIColor colorWithWhite:0.7f alpha:0.5f].CGColor;

  return self;
}

- (void)willEnterHierarchy
{
  [super willEnterHierarchy];

  if (!_displayFinished) {
    [self.layer addSublayer:_placeholderLayer];
  }
}

- (void)layout
{
  _placeholderLayer.frame = (CGRect){ CGPointZero, self.calculatedSize };
}

- (void)displayDidFinish
{
  _displayFinished = YES;
  [_placeholderLayer removeFromSuperlayer];
  [super displayDidFinish];
}

@end
