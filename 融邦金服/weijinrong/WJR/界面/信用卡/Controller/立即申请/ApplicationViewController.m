//
//  ApplicationViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/4.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ApplicationViewController.h"
#import "CardBenifitModel.h"
#import "LinkViewController.h"
#import "CardLinkController.h"

@interface ApplicationViewController ()
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UITextField * nameTF;    //姓名
@property(nonatomic,strong)UITextField * numTF;     //身份证号
@property(nonatomic,strong)UITextField * phoneTF;   //联系方式
@property(nonatomic,strong)UIButton * submitBtn;
@property(nonatomic,strong)BaseModel * models;
@end

@implementation ApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"请输入信息"];
    [self  scrollView];
    [self  showUI];
}

- (void)showUI{
    
    //姓名
    UILabel * label=[[UILabel  alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
    label.backgroundColor=[UIColor  clearColor];
    label.text=@"  真实姓名：";
    label.textColor = [UIColor  lightGrayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont  systemFontOfSize:15];
    _nameTF = [[UITextField  alloc]initWithFrame:CGRectMake(20, 100, ScreenWidth-40, 50)];
    _nameTF.backgroundColor = [UIColor  whiteColor];
    _nameTF.leftView=label;
    _nameTF.keyboardType = UIKeyboardTypeDefault;
    _nameTF.layer.masksToBounds = YES;
    _nameTF.layer.cornerRadius = 5;
    _nameTF.leftViewMode=UITextFieldViewModeAlways;
    _nameTF.contentMode =  UIViewContentModeScaleAspectFit;
    [self.scrollView  addSubview:_nameTF];
    
    
    
    //身份证号
    UILabel * label1=[[UILabel  alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
    label1.backgroundColor=[UIColor  clearColor];
    label1.text=@"  身份证号：";
    label1.textColor = [UIColor  lightGrayColor];
    label1.textAlignment=NSTextAlignmentLeft;
    label1.font=[UIFont  systemFontOfSize:15];
    _numTF = [[UITextField  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_nameTF.frame)+20, ScreenWidth-40, 50)];
    _numTF.backgroundColor = [UIColor  whiteColor];
    _numTF.leftView=label1;
    _numTF.layer.masksToBounds = YES;
    _numTF.layer.cornerRadius = 5;
    _numTF.leftViewMode=UITextFieldViewModeAlways;
    _numTF.contentMode =  UIViewContentModeScaleAspectFit;
    [self.scrollView  addSubview:_numTF];
    
    //联系方式
    UILabel * label2=[[UILabel  alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
    label2.backgroundColor=[UIColor  clearColor];
    label2.text=@"  联系方式：";
    label2.textColor = [UIColor  lightGrayColor];
    label2.textAlignment=NSTextAlignmentLeft;
    label2.font=[UIFont  systemFontOfSize:15];
    _phoneTF = [[UITextField  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_numTF.frame)+20, ScreenWidth-40, 50)];
    _phoneTF.backgroundColor = [UIColor  whiteColor];
    _phoneTF.leftView=label2;
    _phoneTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;  //数字键盘
    _phoneTF.layer.cornerRadius = 5;
    _phoneTF.layer.masksToBounds = YES;
    _phoneTF.leftViewMode=UITextFieldViewModeAlways;
    _phoneTF.contentMode =  UIViewContentModeScaleAspectFit;
    [self.scrollView  addSubview:_phoneTF];
    
    
    //提交
    _submitBtn = [[UIButton  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_phoneTF.frame)+30, ScreenWidth-40, 40)];
    _submitBtn.backgroundColor = [UIColor  redColor];
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius = 5;
    [_submitBtn  setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView  addSubview:_submitBtn];
    
    
    //快速开卡小贴士
    UILabel * label3=[[UILabel  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_submitBtn.frame)+40, 150, 20)];
    label3.backgroundColor=[UIColor  clearColor];
    label3.text=@"快速开卡小贴士";
    label3.textColor = [UIColor  colorWithRed:210/255.0 green:75/255.0 blue:36/255.0 alpha:1];
    label3.textAlignment=NSTextAlignmentLeft;
    label3.font=[UIFont  systemFontOfSize:17];
    [self.scrollView  addSubview:label3];
    
    
    UILabel * label4=[[UILabel  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label3.frame)-10, ScreenWidth-40, 350)];
    label4.backgroundColor=[UIColor  clearColor];
    label4.text=@"1. 信用卡申请人的手机号必须要和征信信息上的手机号一致，征信信息想接近；\n2. 信用卡申请人填写信息必须和法卡迪相吻合;\n3. 信用卡申请人填写个人信息必须完整;\n4. 信用卡申请人准确填写房贷和其他银行信用卡信息;\n5. 使用本手机APP申请信用卡，关闭wifi使用手机流量，提高批卡率;\n6.  例如: \n         山东枣庄用户申请浙商银行信用卡，但是枣庄无浙商银行网点，此时开卡城市就可选择离枣庄最近的网点-济南，录入信息按枣庄用户征信信息填写，枣庄用户征信单位名称：枣庄信用卡有限公司，在手机app上填写工作单位为：“枣庄信用卡有限公司济南分公司”或者“信用卡有限公司”。快卡通道无电话回访。单位地址及家庭住址填写山东省济南市枣庄市**路即可。";
    label4.numberOfLines = 0;
    label4.textColor = [UIColor  lightGrayColor];
    label4.textAlignment=NSTextAlignmentLeft;
    label4.font=[UIFont  systemFontOfSize:15];
    [self.scrollView  addSubview:label4];
    
}

//提交（申请信用卡）
//- (void)btnClick:(UIButton *)btn{
//    [self  showHudLoadingView:@"正在获取。。。"];
//
//    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
//        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
//        [SaveManager  getStringForKey:@"mercId"],@"mercId",
//                                        _model.bankName,@"bankNo", //银行编号
//                                        _nameTF.text,@"applicantName",  //申请人姓名
//                                        _numTF.text,@"crpIdNo",    //身份证号
//                                        _phoneTF.text,@"mobilephone",        //手机号
//                                        _model.id,@"id",     //办卡接口返回的id
//                                                   nil]];
//        [KKTools encryptionJsonString:str];
//    })];
//
//    [DongManager  ApplicationCard:oldParam success:^(id requestData) {
//        [self  hiddenHudLoadingView];
//
//        //解析数据
//        _models = [BaseModel  decryptBecomeModel:requestData];
//        if (_models.retCode == 0) {
//            [self showTitle:_models.retMessage delay:1.5f];
//
//            CardLinkController * linkVC = [[CardLinkController  alloc]init];
//            linkVC.model = _model;
//            [self.navigationController  pushViewController:linkVC animated:YES];
//
//
//        }else {
//            [self showTitle:_models.retMessage delay:1.5f];
//        }
//
//    } fail:^(NSError *error) {
//        [self  showNetFail];
//    }];
//}

//http://123.59.106.50:8187/Financial_app/rbjfResign.html?mercId=9001236456&linkId=27091




//提交（申请信用卡）
- (void)btnClick:(UIButton *)btn {
    [self  showHudLoadingView:@"正在获取。。。"];
    
    NSString *url = [NSString  stringWithFormat:@"http://123.59.106.50:8187/Financial_app/rbjfResign.html?mercId=%@&linkId=%@",[SaveManager  getStringForKey:@"mercId"],_model.id];
    
    //        NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
    //            NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
    //            [SaveManager  getStringForKey:@"mercId"],@"mercId",
    //                                                        _model.id,@"linkId",     //办卡接口返回的id
    //                                                       nil]];
    //            [KKTools encryptionJsonString:str];
    //        })];
    
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   _model.bankName,@"bankNo", //银行编号
                                                   _nameTF.text,@"applicantName",  //申请人姓名
                                                   _numTF.text,@"crpIdNo",    //身份证号
                                                   _phoneTF.text,@"mobilephone",        //手机号
                                                   _model.id,@"id",     //办卡接口返回的id
                                                   @(cityId),@"bdcitycode",
                                                   nil]];
        [KKTools encryptionJsonString:str];
    })];
    
    
    
    //    [DongManager  ApplicationCard:oldParam url:url success:^(id requestData) {
    //                [self  hiddenHudLoadingView];
    //
    //                            //解析数据
    ////                _models = [BaseModel  decryptBecomeModel:requestData];
    ////        _model = [CardBenifitModel decryptBecomeModel:requestData];
    ////                if (_model.retCode == 0) {
    ////                    [self showTitle:_model.retMessage delay:1.5f];
    ////
    ////                    CardLinkController * linkVC = [[CardLinkController  alloc]init];
    //////                    linkVC.cardLink = _model.cardLink;
    //////                    linkVC.urls = url;
    ////                    [self.navigationController  pushViewController:linkVC animated:YES];
    //                }else {
    //                    [self showTitle:_model.retMessage delay:1.5f];
    //                }
    //
    //    } fail:^(NSError *error) {
    //                 [self  showNetFail];
    //    }];
    
    [DongManager ApplicationCard:oldParam success:^(id requestData) {
        _model = [CardBenifitModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [self showTitle:_model.retMessage delay:1.5f];
            CardLinkController * linkVC = [[CardLinkController  alloc]init];
            //                linkVC.cardLink = _model.cardLink;
            //            //                    linkVC.urls = url;
            [self.navigationController  pushViewController:linkVC animated:YES];
        }else {
            [self showTitle:_model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
    
}


#pragma mark--懒加载
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.backgroundColor = [UIColor  groupTableViewBackgroundColor];
        _scrollView.contentSize = CGSizeMake(0, ScreenHeight*2);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view  addSubview:_scrollView];
    }
    return _scrollView;
}


-(void)setModel:(CardBenifitListModel *)model{
    _model = model;
}

@end
