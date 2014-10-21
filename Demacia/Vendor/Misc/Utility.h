//
//  Utility.h
//  Misc_Utility
//
//  Created by Hongyong Jiang on 21/07/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef Misc_Utility_h
#define Misc_Utility_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


#define IPHONE5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)


#endif
