//
//  RequestManager.m
//  CollectionIphone
//
//  Created by 李军 on 16/11/28.
//  Copyright © 2016年 李军. All rights reserved.
//

#import "RequestManager.h"

static NSString * UUID; //随机UUID
static id _responseObject;

@implementation RequestManager

+(void)requestWithURL:(NSString *)url Parameters:(id)parameters Target:(id)target IsFirstRequest:(BOOL)isOrNo Isjson:(BOOL)isjson success:(success)success failure:(failure)failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //状态栏小图标转动
    if (isOrNo) {
        
        [HUDManager loadShowing];
    }
    AFHTTPSessionManager * manager=[self getManager];
    
#pragma 加密设置
//  manager.securityPolicy = [self customSecurityPolicy];

    if (!isjson) {
        
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }else{
        manager.requestSerializer=[[AFJSONRequestSerializer alloc]init];
        manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"url===%@",url);
        DLog(@"parameters===%@",parameters);
        
        [HUDManager loadHideing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            _responseObject = responseObject;
        }else{
            
            SBJsonParser * parser=[[SBJsonParser alloc]init];
            _responseObject = [parser objectWithData:responseObject];
        }
        
        if (success) {
            
            success(_responseObject);
            DLog(@"%@",_responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [HUDManager loadHideing];
        
        if (failure) {
            
            failure(error);
            DLog(@"error:%@",error);
        }
    }];
}

+(AFHTTPSessionManager *)getManager {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//   NSURLRequestReturnCacheDataElseLoad
    
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        DLog(@"setSessionDidBecomeInvalidBlock");
    }];
   
//    //客服端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
//    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
//        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//        __autoreleasing NSURLCredential *credential =nil;
//        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//            if(credential) {
//                disposition =NSURLSessionAuthChallengeUseCredential;
//            } else {
//                disposition =NSURLSessionAuthChallengePerformDefaultHandling;
//            }
//        } else {
//            // client authentication
//            SecIdentityRef identity = NULL;
//            SecTrustRef trust = NULL;
//            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"supuy"ofType:@"p12"];
//            NSFileManager *fileManager =[NSFileManager defaultManager];
//            
//            if(![fileManager fileExistsAtPath:p12])
//            {
//                NSLog(@"supuy.p12:not exist");
//            }
//            else
//            {
//                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
//                
//                if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
//                {
//                    SecCertificateRef certificate = NULL;
//                    SecIdentityCopyCertificate(identity, &certificate);
//                    const void*certs[] = {certificate};
//                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
//                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
//                    disposition =NSURLSessionAuthChallengeUseCredential;
//                }
//            }
//        }
//        *_credential = credential;
//        return disposition;
//    }];
//    
//    UUID=[CommUtls getUUIDString];
//    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
//    [manager.requestSerializer setValue:@"application/vnd.collection.v2+json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:ClientVersion forHTTPHeaderField:@"ClientVersion"];
//    [manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"from"];
//    [manager.requestSerializer setValue:ClientVersion forHTTPHeaderField:@"ClientCode"];
    
//    DLog(@"%d",ISLOGIN);
//    if (ISLOGIN) {
//        NSString * userId=[[CTUserSingle defaultUser].userModel.id stringValue];
//        [manager.requestSerializer setValue:userId forHTTPHeaderField:@"userId"];
//        DLog(@"userId:%@",userId);
//    }else{
//        [manager.requestSerializer setValue:@"0"forHTTPHeaderField:@"userId"];
//    }
    return manager;
}

+ (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"SRCA" ofType:@"der"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [NSSet setWithObject:certData];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    
    securityPolicy.pinnedCertificates = certSet;
    
    
    return securityPolicy;
}

+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"supumall" forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

@end
