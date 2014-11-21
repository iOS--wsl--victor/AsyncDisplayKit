//
//  PostNode.m
//  Sample
//
//  Created by Ryan Nystrom on 11/21/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "PostNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

#import "ShareNode.h"
#import "PlaceholderTextNode.h"

static CGFloat const kTopPadding = 15.f;
static CGFloat const kOuterPadding = 10.f;
static CGFloat const kTextPadding = 10.f;

@interface PostNode ()
{
  PlaceholderTextNode *_textNode;
  PlaceholderTextNode *_dateNode;
  ShareNode *_shareNode;
  ASDisplayNode *_divider;
}

@end

@implementation PostNode

+ (NSDateFormatter *)dateFormatter
{
  NSString * const formatterKey = @"dateFormatter";
  NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
  NSDateFormatter *dateFormatter = threadDictionary[formatterKey];

  if (!dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    threadDictionary[formatterKey] = dateFormatter;
  }

  return dateFormatter;
}

- (instancetype)initWithDate:(NSDate *)date text:(NSString *)text
{
  if (!(self = [super init]))
    return nil;

  NSString *dateString = [[self.class dateFormatter] stringFromDate:date];

  _dateNode = [[PlaceholderTextNode alloc] init];
  _dateNode.attributedString = [[NSAttributedString alloc] initWithString:dateString attributes:[self dateTextStyle]];
  [self addSubnode:_dateNode];

  _textNode = [[PlaceholderTextNode alloc] init];
  _textNode.attributedString = [[NSAttributedString alloc] initWithString:text attributes:[self textStyle]];
  [self addSubnode:_textNode];

  _divider = [[ASDisplayNode alloc] init];
  _divider.backgroundColor = [UIColor lightGrayColor];
  [self addSubnode:_divider];

  _shareNode = [[ShareNode alloc] init];
  [self addSubnode:_shareNode];

  return self;
}

- (NSDictionary *)dateTextStyle
{
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
  UIColor *color = [UIColor colorWithWhite:0.7f alpha:1.f];

  return @{ NSFontAttributeName: font,
            NSForegroundColorAttributeName: color };
}

- (NSDictionary *)textStyle
{
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];

  NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  style.paragraphSpacing = 0.5 * font.lineHeight;
  style.hyphenationFactor = 1.0;

  return @{ NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style };
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  CGSize dateSize = [_dateNode measure:CGSizeMake((constrainedSize.width - 2 * kOuterPadding) / 2.f, constrainedSize.height)];
  CGSize textSize = [_textNode measure:CGSizeMake(constrainedSize.width - 2 * kOuterPadding, constrainedSize.height)];

  [_shareNode measure:constrainedSize];

  return CGSizeMake(constrainedSize.width, dateSize.height + textSize.height + 2 * kTopPadding + kTextPadding);
}

- (void)layout
{
  CGFloat pixelHeight = 1.0f / [[UIScreen mainScreen] scale];
  _divider.frame = CGRectMake(0.0f, 0.0f, self.calculatedSize.width, pixelHeight);

  CGSize dateSize = _dateNode.calculatedSize;
  _dateNode.frame = CGRectMake(kOuterPadding, kTopPadding, dateSize.width, dateSize.height);

  CGSize textSize = _textNode.calculatedSize;
  _textNode.frame = CGRectMake(kOuterPadding, CGRectGetMaxY(_dateNode.frame) + kTextPadding, textSize.width, textSize.height);

  CGSize iconSize = _shareNode.calculatedSize;
  _shareNode.frame = CGRectMake(self.calculatedSize.width - kOuterPadding - iconSize.width, kTopPadding, iconSize.width, iconSize.width);
}

@end
