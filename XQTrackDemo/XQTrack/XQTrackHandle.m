//
//  XQTrackHandle.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/4.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "XQTrackHandle.h"
#import "XQTrackData.h"
NSString * const KEY_UDID_INSTEAD = @"com.myapp.udid.test";

@implementation XQTrackHandle

+ (NSString *)getPhoneIdentifier
{
    NSString *getUDIDInKeychain = (NSString *)[XQTrackHandle load:KEY_UDID_INSTEAD];
//    NSLog(@"从keychain中获取到的 UDID_INSTEAD %@",getUDIDInKeychain);
    if (!getUDIDInKeychain ||[getUDIDInKeychain isEqualToString:@""]||[getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
//        NSLog(@"\n \n \n _____重新存储 UUID _____\n \n \n  %@",result);
        [XQTrackHandle save:KEY_UDID_INSTEAD data:result];
        getUDIDInKeychain = (NSString *)[XQTrackHandle load:KEY_UDID_INSTEAD];
    }
//    NSLog(@"最终 ———— UDID_INSTEAD %@",getUDIDInKeychain);
    return getUDIDInKeychain;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (void)printSortAllKeys:(NSDictionary *)dic message:(NSString *)message
{
    NSLog(@"%@++++++++++++++%@==>%@",[self class] , message, [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [dic[obj1] compare:dic[obj2]];
        return result==NSOrderedDescending;
    }]);
}

+ (NSString *)strDate:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (void)savaData:(NSObject *)object message:(NSString *)msg
{
    XQTrackModel * md = [[XQTrackModel alloc] init];
    NSString * className = [NSString stringWithUTF8String:object_getClassName(object)];
    md.timeStr = [XQTrackHandle strDate:[NSDate date]];
    md.message = [NSString stringWithFormat:@"用户 %@ 在 %@ %@ %@",@"小强"/*[XQTrackHandle getPhoneIdentifier]*/,md.timeStr,object.trackMessage ? @"": msg,object.trackMessage ? : className];
    md.className = className;
    [[XQTrackData sharedInstance] queryTrackModel:md];
}

+(CGSize)sizeWithStr:(NSString *)str withMaxWidth:(CGFloat)maxWidth withFont:(CGFloat)fontSize
{
    CGSize size;
    
    if(str.length == 0)
    {
        size = CGSizeMake(0, 0);
        return size;
    }
    CGSize textBlockMinSize = {maxWidth, CGFLOAT_MAX};
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:XQ_CONST_NUM_ZERO];//调整行间距
    size = [str boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{
                                       NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                       NSParagraphStyleAttributeName:paragraphStyle
                                       }
                             context:nil].size;
    //    return size;
    return CGSizeMake(size.width, ceil(size.height) + 1.0);
}
@end
