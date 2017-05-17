//
//  JMSingleton.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

// .h
#define JMSingleton_interface(class) + (instancetype)shared##class;

// .m
#define JMSingleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}


