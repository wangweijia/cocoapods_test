//
//  ViewController.m
//  ZBarSDK_test
//
//  Created by apple on 5/22/15.
//  Copyright (c) 2015 com.eku001. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"

@interface ViewController ()<ZBarReaderViewDelegate,UIAlertViewDelegate>

//@property (nonatomic, strong) ZBarReaderView *readerView;

@property (nonatomic, strong) ZBarCameraSimulator *cameraSim;

@property (nonatomic, weak) ZBarReaderView *readView;

@property (nonatomic, strong) UIImageView *scanZomeBack;

@property (nonatomic, strong) UIImageView *readLineView;

@property (weak, nonatomic) UIView *boxView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initZBar];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewDidDisappear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initZBar{
    ZBarReaderView *readView = [ZBarReaderView new];
    readView.backgroundColor = [UIColor redColor];
    readView.frame = [UIScreen mainScreen].bounds;
    readView.readerDelegate = self;
    readView.trackingColor = [UIColor clearColor];
    [readView setMaxZoom:1.0];
    self.readView = readView;
    
    UIImage *hbImage=[UIImage imageNamed:@"temp1"];
    self.scanZomeBack=[[UIImageView alloc] initWithImage:hbImage];
//    添加一个背景图片
    CGRect mImagerect=CGRectMake((readView.frame.size.width-200)/2.0, (readView.frame.size.height-200)/2.0, 200, 200);
    [self.scanZomeBack setFrame:mImagerect];
    readView.scanCrop = [self getScanCrop:mImagerect readerViewBounds:readView.bounds];//将被扫描的图像的区域
    
    [readView addSubview:self.scanZomeBack];
    [readView addSubview:_readLineView];
    [self.view addSubview:readView];
    
    [readView start];
    [self loopDrawLine];
}

- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    CGRect aRect = CGRectMake(x, y, width, height);
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    aView.backgroundColor = [UIColor clearColor];
    aView.layer.borderColor = [[UIColor blueColor] CGColor];
    aView.layer.borderWidth = 1.0;
    [self.readView addSubview:aView];
    
    return aRect;
}

-(void)loopDrawLine{
    
//    NSLog(@"captureReader:%@",_readView.captureReader);
//    NSLog(@"session:%@",_readView.session);
    
    CGRect  rect = CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y, _scanZomeBack.frame.size.width, 2);
    if (_readLineView) {
        [_readLineView removeFromSuperview];
    }
    _readLineView = [[UIImageView alloc] initWithFrame:rect];
    [_readLineView setImage:[UIImage imageNamed:@"line.png"]];
    [UIView animateWithDuration:2.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //修改fream的代码写在这里
                         _readLineView.frame =CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y + _scanZomeBack.frame.size.height, _scanZomeBack.frame.size.width, 2);
                         [_readLineView setAnimationRepeatCount:0];
                         
                     }
                     completion:^(BOOL finished){
//                         if (!is_Anmotion) {
                         
                             [self loopDrawLine];
//                         }
                         
                     }];
    
    [self.readView addSubview:_readLineView];
    
}

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    NSString *codeData = [[NSString alloc] init];;
    for (ZBarSymbol *sym in symbols) {
        codeData = sym.data;
        break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"掃描結果" message:codeData delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [_readerView start];
}



@end
