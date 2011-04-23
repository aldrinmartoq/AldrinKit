// AldrinKitPlugin.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>
@import "GoogleMapsView.j"
@import "GoogleMapsView.j"

@implementation AldrinKitPlugin : AKPlugin {
}

- (CPArray)libraryCibNames {
    return [@"AldrinKit.cib"];
}

- (void)init {
    self = [super init];

    if (self) {
        [_classDescriptions setObject:[CPDictionary dictionaryWithJSObject:{
            "ClassName"     : "CPTableView",
            "SuperClass"    : "CPControl",
            "Outlets"       : {
                "delegate"      : "id",
                "dataSource"    : "id"
            }
        } recursively:YES] forKey:@"CPTableView"];

        [_classDescriptions setObject:[CPDictionary dictionaryWithJSObject:{
            "ClassName"     : "GoogleMapsView",
            "SuperClass"    : "CPView",
            "Outlets"       : {
                "delegate"      : "id"
            }
        } recursively:YES] forKey:@"GoogleMapsView"];

        [_classDescriptions setObject:[CPDictionary dictionaryWithJSObject:{
            "ClassName"     : "RutTextField",
            "SuperClass"    : "CPSearchField",
            "Actions"       : {
                "performClick:"  : "id"
            }
        } recursively:YES] forKey:@"RutTextField"];
    }

    return self;
}

@end
