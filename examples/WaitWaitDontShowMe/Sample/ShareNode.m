//
//  ShareNode.m
//  Sample
//
//  Created by Ryan Nystrom on 11/21/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "ShareNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

static NSUInteger const kRingCount = 3;
static CGFloat const kRingStrokeWidth = 1.f;
static CGSize const kIconSize = (CGSize){ 40.f, 10.f };

@interface ShareNode ()
{
  ASImageNode *_iconNode;
}

@end

@implementation ShareNode

+ (UIImage *)drawIcon
{
  UIGraphicsBeginImageContextWithOptions(kIconSize, NO, [UIScreen mainScreen].scale);

  [[UIColor colorWithRed:0.f green:122/255.f blue:1.f alpha:1.f] setStroke];

  for (NSUInteger i = 0; i < kRingCount; i++) {
    CGFloat x = i * kIconSize.width / kRingCount;
    CGRect frame = CGRectMake(x, 0.f, kIconSize.height, kIconSize.height);
    CGRect strokeFrame = CGRectInset(frame, kRingStrokeWidth, kRingStrokeWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeFrame cornerRadius:kIconSize.height / 2.f];
    [path setLineWidth:kRingStrokeWidth];
    [path stroke];
  }

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

- (instancetype)init
{
  if (!(self = [super init]))
    return nil;

  _iconNode = [[ASImageNode alloc] init];
  _iconNode.image = [self.class drawIcon];
  [self addSubnode:_iconNode];

  return self;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  return kIconSize;
}

- (void)layout
{
  _iconNode.frame = (CGRect){ CGPointZero, self.calculatedSize };
}

@end
