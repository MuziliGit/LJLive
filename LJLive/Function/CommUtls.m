//
//  CommUtls.m
//  Function
//
//  Created by 李军 on 16/11/8.
//  Copyright © 2016年 李军. All rights reserved.
//

#import "CommUtls.h"

@implementation CommUtls


+(NSString*)timeToTranslate:(NSNumber *)time
{
    return [self timeToTranslate:time Formatter:@"YYYY-MM-dd"];
}

+ (NSString*)timeToTranslate1:(NSNumber *)time {
    
    return [self timeToTranslate:time Formatter:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSString*)timeToTranslate:(NSNumber *)time Formatter:(NSString*)formatterStr
{
    long long int date1 = (long long int)[time intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    NSString *nowtimeStr = [formatter stringFromDate:date2];
    return nowtimeStr;
}

+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

+ (NSString *)encodeTime:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

+ (NSDate *)dencodeTime:(NSString *)dateString

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }

}

+ (NSString *)changeSecondsToString:(CGFloat)durartion
{
    int hh = durartion/(60 * 60);
    int mm = hh > 0 ? (durartion - 60*60)/60 : durartion/60;
    int ss = (int)durartion%60;
    NSString *hhStr,*mmStr,*ssStr;
    if (hh == 0) {
        hhStr = @"00";
    }else if (hh > 0 && hh < 10) {
        hhStr = [NSString stringWithFormat:@"0%d",hh];
    }else {
        hhStr = [NSString stringWithFormat:@"%d",hh];
    }
    if (mm == 0) {
        mmStr = @"00";
    }else if (mm > 0 && mm < 10) {
        mmStr = [NSString stringWithFormat:@"0%d",mm];
    }else {
        mmStr = [NSString stringWithFormat:@"%d",mm];
    }
    if (ss == 0) {
        ssStr = @"00";
    }else if (ss > 0 && ss < 10) {
        ssStr = [NSString stringWithFormat:@"0%d",ss];
    }else {
        ssStr = [NSString stringWithFormat:@"%d",ss];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hhStr,mmStr,ssStr];
}


//时间戳转换日期
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    
    if (distanceTime <2*60*60) {//时间小于2个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }else if(distanceTime <3*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于3小时
        distanceStr = @"2小时前";
    }else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"%@",timeStr];
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}


+ (BOOL)fileExists:(NSString *)fullPathName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fullPathName];
}

+ (BOOL)remove:(NSString *)fullPathName
{
    NSError *error = nil;
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:fullPathName]) {
        [file_manager removeItemAtPath:fullPathName error:&error];
    }
    if (error) {
        return NO;
    }
    return YES;
}

+ (void)makeDirs:(NSString *)dir
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    [file_manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)fileExistInDocumentPath:(NSString*)fileName

{
    if(fileName == nil)
        return NO;
    NSString* documentsPath = [self documentPath:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath: documentsPath];
}

+ (NSString*)documentPath:(NSString*)fileName

{
    if(fileName == nil)
        return nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex: 0];
    NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
    return documentsPath;
}

+ (BOOL)deleteDocumentFile:(NSString*)fileName

{
    BOOL del = NO;
    if(fileName == nil)
        return del;
    NSString* documentsPath = [self documentPath:fileName];
    if( [[NSFileManager defaultManager] fileExistsAtPath: documentsPath])
    {
        
        del = [[NSFileManager defaultManager] removeItemAtPath: documentsPath error:nil];
    }
    return del;
}

+ (BOOL)fileExistInCachesPath:(NSString*)fileName

{
    if(fileName == nil)
        return NO;
    NSString* cachesPath = [self cachesFilePath:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath: cachesPath];
}

+ (NSString* )cachesFilePath:(NSString*)fileName
{
    if(fileName == nil)
        return nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesdirectory = [paths objectAtIndex: 0];
    NSString* cachesPath = [cachesdirectory stringByAppendingPathComponent:fileName];
    return cachesPath;
}

+ (BOOL)deleteCachesFile:(NSString*)fileName

{
    BOOL del = NO;
    if(fileName == nil)
        return del;
    NSString* cachesPath = [self cachesFilePath:fileName];
    if( [[NSFileManager defaultManager] fileExistsAtPath: cachesPath])
    {
        del = [[NSFileManager defaultManager] removeItemAtPath: cachesPath error:nil];
    }
    return del;
}

+ (NSString*)getSize:(NSNumber*)number

{
    NSInteger size=[number intValue];
    if(size<1024)
        return [NSString stringWithFormat:@"%ldB", (long)size];
    else
    {
        NSInteger size1=size/1024;
        if(size1<1024)
        {
            return [NSString stringWithFormat:@"%ld.%dKB", (long)size1,(size-size1*1024)/10];
        }
        else
        {
            NSInteger size2=size1/1024;
            if(size2<1024)
                return [NSString stringWithFormat:@"%ld.%dMB", (long)size2,(size1-size2*1024)/10];
        }
    }
    return nil;
}

+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max
{
    NSInteger value=0;
    if(min>0)
        value= (arc4random() % (max-min+1)) + min;
    else
        value= arc4random() % max;
    return value;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSString *)getMacAddress{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;

}

+ (BOOL)checkConnectNet{
    
    struct  sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *) &zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES:NO;
}

+ (UIColor *)getRandomColor
{
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

+(NSString *)getUUIDString
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+(UIImage*)getImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(NSString *)getDeviceBounds
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    if (rect.size.width ==480||rect.size.height ==480) {
        return @"4";
    }else if (rect.size.width==568||rect.size.height ==568)
    {
        return @"5";
        
    }else if (rect.size.width==667||rect.size.height ==667)
    {
        return @"6";
        
    }else if (rect.size.width==736||rect.size.height ==736)
    {
        return @"6p";
        
    }else if (rect.size.width==1024||rect.size.height ==1024)
    {
        return @"ipad";
        
    }
    return nil;
}


+(CGSize)calculateHeightWithText:(NSString *)text MaxSize:(CGSize)maxSize Font:(UIFont *)font{
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
}

+(BOOL)cheakMobileWithText:(NSString *)text{
    
    if (text.length == 0) {
        [HUDManager loaderrorMessage:@"手机号码不能为空"];
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:text];
    
    if (!isMatch) {
        
        [HUDManager loaderrorMessage:@"请输入正确的手机号"];
        
        return NO;
    }
    return YES;
}

+(id)returnDictionaryOrArray:(NSString *)jeson {
    
    NSMutableString *content = [NSMutableString stringWithString:jeson];
    NSString *character = nil;
    
    for (int i = 0; i < content.length; i++) {
        
        character = [content substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@"\\"]) {
            
            [content deleteCharactersInRange:NSMakeRange(i, 1)];
        }
    }
    
    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    
    if(err) {
        
        DLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return jsonObject;
}

+ (NSString *)base64PhotoString:(NSArray *)photoArray {
    
    NSString * photosString = [[NSString alloc] init];
    
    NSMutableArray *arrPic = [[NSMutableArray alloc] init];
    
    UIImage *image = photoArray[photoArray.count - 1];
    
    NSInteger j = 0;
    if (image.size.width == 315) {
        
        j = photoArray.count-1;
    }else {
        
        j = photoArray.count;
    }
    
    for (int i = 0; i < j; i++) {
        UIImage *image = photoArray[i];
        NSData *data = UIImageJPEGRepresentation(image, 0.2f);
        
        NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *str1 = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",str];
        [arrPic addObject:str1];
    }
    photosString=[arrPic componentsJoinedByString:@"|"];
    
    photosString = [NSString stringWithFormat:@"%@|",photosString];
    
    return photosString;
}

+ (NSString *)base64EncodeString:(NSString *)string

{
    
    //1.先把字符串转换为二进制数据
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:0];
}

+(void)pushWithFrom:(UIViewController *)from To:(UIViewController *)toController{
    
    [from.view endEditing:YES];
    [from.navigationController pushViewController:toController animated:YES];
}

+(void)popWithFrom:(UIViewController*)from To:(Class)toControllerClass {
    
    for (UIViewController *controller in from.navigationController.viewControllers) {
        if ([controller isKindOfClass:toControllerClass]) {
            
            [from.navigationController popToViewController:controller animated:YES];
        }
    }
}

@end


