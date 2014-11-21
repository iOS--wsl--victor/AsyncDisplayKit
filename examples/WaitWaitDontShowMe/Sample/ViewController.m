/* This file provided by Facebook is for non-commercial testing and evaluation
 * purposes only.  Facebook reserves all rights not expressly granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "ViewController.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "PostNode.h"

static NSUInteger const kNumberOfPosts = 20;

@interface ViewController () <ASTableViewDataSource, ASTableViewDelegate>
{
  ASTableView *_tableView;
  UIButton *_displayButton;
}

@end

@implementation ViewController

- (instancetype)init
{
  if (self = [super init]) {
    _tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.asyncDataSource = self;
    _tableView.asyncDelegate = self;

    _displayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_displayButton setTitle:@"Show me!" forState:UIControlStateNormal];
    [_displayButton addTarget:self action:@selector(onDisplay:) forControlEvents:UIControlEventTouchUpInside];
    _displayButton.backgroundColor = [UIColor whiteColor];

    UIColor *titleColor = [UIColor colorWithRed:0.f green:122/255.f blue:1.f alpha:1.f];
    [_displayButton setTitleColor:titleColor forState:UIControlStateNormal];
    [_displayButton setTitleColor:[titleColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
  }

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.view addSubview:_tableView];
  [self.view addSubview:_displayButton];
}

- (void)viewDidLayoutSubviews
{
  CGRect bounds = self.view.bounds;
  _tableView.frame = bounds;
  _displayButton.frame = (CGRect){ 0, CGRectGetHeight(bounds) - 44, CGRectGetWidth(bounds), 44 };
}

- (BOOL)prefersStatusBarHidden
{
  return YES;
}


#pragma mark -
#pragma mark Getters

+ (NSString *)randomPost
{
  static NSArray *posts = nil;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    posts = @[
              @"Nulla vitae elit libero, a pharetra augue. Curabitur blandit tempus porttitor. Donec sed odio dui. Donec id elit non mi porta gravida at eget metus. Donec ullamcorper nulla non metus auctor fringilla. Cras mattis consectetur purus sit amet fermentum.",
              @"Donec id elit non mi porta gravida at eget metus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Donec id elit non mi porta gravida at eget metus.\nFusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec ullamcorper nulla non metus auctor fringilla.",
              @"Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.\nNullam id dolor id nibh ultricies vehicula ut id elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              @"Sed posuere consectetur est at lobortis. Etiam porta sem malesuada magna mollis euismod. Curabitur blandit tempus porttitor. Nullam id dolor id nibh ultricies vehicula ut id elit.\nCurabitur blandit tempus porttitor.",
              @"Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Vestibulum id ligula porta felis euismod semper. Nullam id dolor id nibh ultricies vehicula ut id elit.Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ullamcorper nulla non metus auctor fringilla.",
              @"Nullam quis risus eget urna mollis ornare vel eu leo.\nSed posuere consectetur est at lobortis. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Nulla vitae elit libero, a pharetra augue.",
              ];
  });

  NSUInteger randomIndex = arc4random() % posts.count;
  return posts[randomIndex];
}


#pragma mark -
#pragma mark Actions

- (void)onDisplay:(id)sender
{
  [_tableView reloadData];
}


#pragma mark - 
#pragma mark ASTableViewDataSource

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-indexPath.row * 60 * 60 * 24];
  NSString *text = [self.class randomPost];
  PostNode *node = [[PostNode alloc] initWithDate:date text:text];
  return node;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return kNumberOfPosts;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}

@end
