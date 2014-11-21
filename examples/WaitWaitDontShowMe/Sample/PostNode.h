//
//  PostNode.h
//  Sample
//
//  Created by Ryan Nystrom on 11/21/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface PostNode : ASCellNode

- (instancetype)initWithDate:(NSDate *)date text:(NSString *)text;

@end
