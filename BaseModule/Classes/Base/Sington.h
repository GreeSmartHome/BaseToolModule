//
//  Sington.h
//  Pods
//
//  Created by 冉东军 on 2020/2/25.
//


#define singtonInterface  + (instancetype)shareInstance;



#define singtonImplement(class) \
\
static class *_shareInstance; \
\
+ (instancetype)shareInstance { \
\
    if(_shareInstance == nil) {\
        _shareInstance = [[class alloc] init]; \
    } \
    return _shareInstance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone { \
\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _shareInstance = [super allocWithZone:zone]; \
    }); \
\
    return _shareInstance; \
\
}

#endif /* Sington_h */
