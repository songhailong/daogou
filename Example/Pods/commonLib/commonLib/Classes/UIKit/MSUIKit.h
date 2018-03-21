//
//  MSHTTP.h
//  EMStock
//
//  Created by flora on 14-9-12.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//

#ifndef MSUIKIT_H
#define MSUIKIT_H

#ifdef __has_include

#if __has_include(<MSUIKitCore.h>)
#import <MSUIKitCore.h>
#endif

#if __has_include(<MSAnimations.h>)
#import <MSAnimations.h>
#endif

#if __has_include(<CollectionModels.h>)
#import <CollectionModels.h>
#endif

#if __has_include(<FontAwesome.h>)
#import <FontAwesome.h>
#endif

#if __has_include(<GuideView.h>)
#import <GuideView.h>
#endif

#if __has_include(<MultiPaging.h>)
#import <MultiPaging.h>
#endif


#if __has_include(<PopupView.h>)
#import <PopupView.h>
#endif

#if __has_include(<StatusBar.h>)
#import <StatusBar.h>
#endif

#if __has_include(<TableModels.h>)
#import <TableModels.h>
#endif


#if __has_include(<UIColors.h>)
#import <UIColors.h>
#endif

#if __has_include(<UIImages.h>)
#import <UIImages.h>
#endif


#if __has_include(<UIKitCollections.h>)
#import <UIKitCollections.h>
#endif

#if __has_include(<WebImage.h>)
#import <WebImage.h>
#endif


#endif /* MSUIKIT_H */

#else

#warning "Xcode7以下没有__has_include 请直接使用UIKit的子模块"

#endif /* __has_include */
