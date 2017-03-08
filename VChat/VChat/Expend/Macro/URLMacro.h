//
//  URLMacro.h
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h

#define URL_HOST @"http://192.168.1.189:8080/luck"
#define URL_TEST @"http://192.168.31.165:8080/luck"

#ifdef DEBUG
#define URLPath(path) [NSString stringWithFormat:@"%@%@",URL_TEST,path]
#else
#define URLPath(path) [NSString stringWithFormat:@"%@%@",URL_HOST,path]
#endif




#define URL_USER_LOGIN      URLPath(@"/user/toLogin")
#define URL_USER_REGISTER   URLPath(@"/user/toRegister")

#endif /* URLMacro_h */
