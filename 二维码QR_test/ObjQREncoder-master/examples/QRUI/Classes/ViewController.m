/**
 * Copyright 2009
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <QuartzCore/QuartzCore.h>
#import <QREncoder/QREncoder.h>
#import "ViewController.h"

static const CGFloat kPadding = 10;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ViewController


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [QREncoder encode:@"Eku001"];

	UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
  CGFloat qrSize = self.view.bounds.size.width - kPadding * 2;
	imageView.frame = CGRectMake(kPadding, (self.view.bounds.size.height - qrSize) / 2,
    qrSize, qrSize);
    imageView.backgroundColor = [UIColor blueColor];
	[imageView layer].magnificationFilter = kCAFilterNearest;

	[self.view addSubview:imageView];
    
    UIImageView *aView = [[UIImageView alloc] init];
    aView.backgroundColor = [UIColor whiteColor];
    aView.image = [UIImage imageNamed:@"aImage"];
    
    CGFloat w = 100.0;
    CGFloat h = 100.0;
    CGFloat x = (CGRectGetMaxX(imageView.frame) - w + CGRectGetMinX(imageView.frame)) / 2;
    CGFloat y = (CGRectGetMaxY(imageView.frame) - h + CGRectGetMinY(imageView.frame)) / 2;

    aView.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:aView];
    
  [imageView release];
}

@end
