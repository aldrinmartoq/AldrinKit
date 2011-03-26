// AldrinKitPlugin.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>

@implementation AldrinKitPlugin : AKPlugin {
}

- (CPArray)libraryCibNames {
  return [@"GoogleMapsView.cib"];
}

- (void)init {
  self = [super init];
  
  if (self) {
  }
  
  return self;
}

@end
