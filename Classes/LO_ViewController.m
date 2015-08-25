//
//  LO_ViewController.m
//  LO_EncryptDo
//
//  Created by Lawliet on 15/8/20.
//  Copyright (c) 2015年 Lawliet. All rights reserved.
//

#import "LO_ViewController.h"
#import "NSString+LO_MD5.h"
#import "GTMBase64.h"

@interface LO_ViewController ()
{
    // Encryption result
    UILabel *reminderLabel;
    
    NSString *str;
}

@end

@implementation LO_ViewController

/**
 *  LazyLoading
 *
 */
- (UILabel *)reminderLabel
{
    if (reminderLabel == nil) {
        
        reminderLabel = [[UILabel alloc] init];
        
    }
    return reminderLabel;
    
}

/**
 *  LazyLoading
 *
 */
- (NSString *)str
{
    if (str == nil) {
        
        str = [[NSString alloc] init];
        
    }
    return str;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

#if 1
    {
    // 输入需要加密的字符
    inputField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 200, 60)];
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    inputField.adjustsFontSizeToFitWidth = YES;
    inputField.placeholder = @"请输入需要加密的字符";
    [self.view addSubview:inputField];
    
    // 提示框
    reminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 410, 150, 40)];
    [reminderLabel setText:@"加密后的结果为:"];
    reminderLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:reminderLabel];
    
    // 显示加密后的结果
    outputLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, [UIScreen mainScreen].bounds.size.width, 80)];
    outputLabel.backgroundColor = [UIColor greenColor];
    outputLabel.textColor = [UIColor blackColor];
    outputLabel.lineBreakMode = NSLineBreakByWordWrapping;
    outputLabel.numberOfLines = 0;
    [self.view addSubview:outputLabel];
    }
#endif
    
    // 进行MD5加密
#if 1
    {
        UIButton *buttonMD5  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonMD5.frame = CGRectMake(50, 100, 200, 50);
        buttonMD5.backgroundColor = [UIColor redColor];
        buttonMD5.layer.borderWidth = 2.0;
        buttonMD5.tintColor = [UIColor blackColor];
        [buttonMD5 setTitle:@"MD5加密" forState:UIControlStateNormal];
        [buttonMD5 addTarget:self action:@selector(buttonPressedMD5:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonMD5];
    }
#endif

    // 进行MD5加盐加密
#if 1
    {
        UIButton *buttonMD5Salt  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonMD5Salt.frame = CGRectMake(50, 150, 200, 50);
        buttonMD5Salt.backgroundColor = [UIColor grayColor];
        buttonMD5Salt.layer.borderWidth = 2.0;
        [buttonMD5Salt setTitle:@"MD5加盐加密" forState:UIControlStateNormal];
        [buttonMD5Salt addTarget:self action:@selector(buttonPressedMD5Salt:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonMD5Salt];
    }
#endif
    
    // 进行MD5+HMAC加密的按钮
#if 1
    {
        UIButton *buttonMD5HMAC  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonMD5HMAC.frame = CGRectMake(50, 200, 200, 50);
        buttonMD5HMAC.backgroundColor = [UIColor blueColor];
        buttonMD5HMAC.layer.borderWidth = 2.0;
        [buttonMD5HMAC setTitle:@"MD5＋HMAC" forState:UIControlStateNormal];
        [buttonMD5HMAC addTarget:self action:@selector(buttonPressedMD5HMAC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonMD5HMAC];
    }
#endif

    // 进行SHA1加密
#if 1
    {
        UIButton *buttonSHA1  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSHA1.frame = CGRectMake(50, 250, 200, 50);
        buttonSHA1.backgroundColor = [UIColor greenColor];
        buttonSHA1.layer.borderWidth = 2.0;
        buttonSHA1.tintColor = [UIColor blackColor];
        [buttonSHA1 setTitle:@"SHA1加密" forState:UIControlStateNormal];
        [buttonSHA1 addTarget:self action:@selector(buttonPressedSHA1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonSHA1];
    }
#endif
    
    // 进行Base64加密的按钮(iOS7.0+)
#if 1
    {
        UIButton *buttonBase64  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBase64.frame = CGRectMake(50, 300, 200, 50);
        buttonBase64.backgroundColor = [UIColor grayColor];
        buttonBase64.layer.borderWidth = 2.0;
        [buttonBase64 setTitle:@"Base64加密" forState:UIControlStateNormal];
        [buttonBase64 addTarget:self action:@selector(buttonPressedBase64:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonBase64];
    }
#endif
    
    // 进行GTMBase64加密的按钮
#if 1
    {
        UIButton *buttonGTMBase64  = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonGTMBase64.frame = CGRectMake(50, 350, 200, 50);
        buttonGTMBase64.backgroundColor = [UIColor cyanColor];
        buttonGTMBase64.layer.borderWidth = 2.0;
        [buttonGTMBase64 setTitle:@"GTMBase64加密" forState:UIControlStateNormal];
        [buttonGTMBase64 addTarget:self action:@selector(buttonPressedBase64:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonGTMBase64];
    }
#endif
}

#pragma mark - 以下为按钮的事件
/**
 *  为字符进行MD5加密
 *
 */
- (void)buttonPressedMD5:(UIButton *)button
{
    str = [inputField.text md5String];
    
    outputLabel.text = str;
    
}

/**
 *  为字符进行MD5加盐加密
 *
 */
- (void)buttonPressedMD5Salt:(UIButton *)button
{
    // 盐: 长，复杂，无实际意义
    static NSString *saltStr = @"fsfsdf##$#%%@5tg65533";
    
    str = [[inputField.text stringByAppendingString:saltStr] md5String];
    
    outputLabel.text = str;
    
    
}

/**
 *  为字符进行HMAC＋MD5加密
 *
 */
- (void)buttonPressedMD5HMAC:(UIButton *)button
{
    NSString *key = @"dasdas#@#@32";
    str = [inputField.text hmacMD5StringWithKey:key];
    
    outputLabel.text = str;
    
}

/**
 *  SHA1加密
 *
 */
- (void)buttonPressedSHA1:(UIButton *)button
{
    str = [[inputField.text sha1String] md5String];
//    str = [inputField.text sha256String];
    outputLabel.text = str;
    
}

/**
 *  iOS7.0以上的Base64加密
 *
 */
- (void)buttonPressedBase64:(UIButton *)button
{
    str = [self base64encode:inputField.text];
    
    outputLabel.text = str;
}

/**
 *  为字符进行GTMBase64加密
 *
 */

- (void)buttonPressedGTMBase64:(UIButton *)button
{
    str = [self useGTMBase64encode:inputField.text];
    
    outputLabel.text = str;
    
}

/**
 *  GTMBase64加密
 *
 *  @param strGTM 传入需要加密的字符
 *
 *  @return 加密后的字符
 */
- (NSString *)useGTMBase64encode:(NSString *)strGTM
{
    NSData *data = [strGTM dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return retStr;
    
}

/**
 *  iOS7.0以上的系统自带的Base64加密
 *
 *  @param strs 传入需要加密的字符
 *
 *  @return 加密后的字符
 */
- (NSString *)base64encode:(NSString *)strs
{
    NSData *data = [strs dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

@end
