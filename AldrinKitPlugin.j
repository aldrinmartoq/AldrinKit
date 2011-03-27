// AldrinKitPlugin.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>
@import "GoogleMapsView.j"
@import "CPActiveRecord.j"

@implementation AldrinKitPlugin : AKPlugin {
}

- (CPArray)libraryCibNames {
  return [@"GoogleMapsView.cib", @"CPTableView.cib"];
}

- (void)init {
  self = [super init];
  
  if (self) {
      [_classDescriptions setObject:[CPDictionary dictionaryWithJSObject:{
          "ClassName"   : "CPTableView",
          "SuperClass"  : "CPControl",
          "Outlets"     : {
              "delegate" : "id",
              "dataSource" : "id"
          }
      } recursively:YES] forKey:@"CPTableView"];
  }
  
  return self;
}

@end
