// CPTabViewAttributeInspector.j
// AldrinKit
// 
// Created by Aldrin Martoq on April 22, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>

@implementation CPTabViewAttributeInspector : AKInspector {
    @outlet CPTableView         viewsTable;
    CPTableColumn               viewsTableTitle;
    CPTableColumn               viewsTableIdentifier;
    @outlet CPButton            viewsAdd;
    @outlet CPButton            viewsRemove;
    CPTabView                   tabView;
}

- (CPString)label {
    return @"Tab View";
}

- (CPString)viewCibName {
    return @"CPTabViewAttributeInspector";
}

- (void)awakeFromCib {
    var cols = [viewsTable tableColumns];
    viewsTableTitle = cols[0];
    viewsTableIdentifier = cols[1];

    [viewsTable setDelegate:self];
    [viewsTable setDataSource:self];    
}

- (void)refresh {
    var inspectedObjects = [self inspectedObjects];

    if ([inspectedObjects count] != 1) {
        [viewsTable setEnabled:NO];
        tabView = null;
    } else {
        [viewsTable setEnabled:YES];
        tabView = inspectedObjects[0];
    }

    [viewsTable reloadData];
}

- (@action)addView:(id)aSender {
    var len = [tabView numberOfTabViewItems];
    var identifier = "" + (len + 1);
    var name = "Tab " + identifier;
    
    var v = [[CPScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([tabView bounds]), 50.0)];
        
    var tabViewItem = [[CPTabViewItem alloc] initWithIdentifier:identifier];
    [tabViewItem setLabel:name];
    [tabViewItem setView:v];
    
    [tabView addTabViewItem:tabViewItem];
    [tabView selectLastTabViewItem:null];
    [viewsTable reloadData];
    // var cols = [tableView tableColumns];
    // var identifier = "" + cols.length;
    // var name = "Column " + identifier;
    // 
    // var col = [[CPTableColumn alloc] initWithIdentifier:identifier];
    // [[col headerView] setStringValue:name];
    // [[col headerView] sizeToFit];
    // [tableView addTableColumn:col];
    // 
    // [tableColumnsTable reloadData];
    // [tableView display];
}

- (@action)removeView:(id)aSender {
    // var rowIndex = [tableColumnsTable selectedRow];
    // var cols = [tableView tableColumns];
    // 
    // if (rowIndex < 0) {
    //     return;
    // }
    // var tableColumn = cols[rowIndex];
    // 
    // [tableView removeTableColumn:tableColumn];
    // 
    // [tableColumnsTable reloadData];
    // [tableView display];
}

@end

@implementation CPTabViewAttributeInspector (CPTableView)

- (int)numberOfRowsInTableView:(CPTableView)aTableView {
    return [tabView numberOfTabViewItems];
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex {
    var viewItems = [tabView tabViewItems];

    if (aTableColumn == viewsTableTitle) {
        return [viewItems[rowIndex] label];
    } else if (aTableColumn == viewsTableIdentifier) {
        return [viewItems[rowIndex] identifier];
    }

    return '-';
}

- (void)tableView:(CPTableView)aTableView setObjectValue: (CPControl)anObject forTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex {
    var viewItems = [tabView tabViewItems];

    if (aTableColumn == viewsTableTitle) {
        [viewItems[rowIndex] setLabel:anObject];
        [tabView _updateItems];
    } else if (aTableColumn == viewsTableIdentifier) {
        [viewItems[rowIndex] setIdentifier:anObject];
    }
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification {
    var rowIndex = [viewsTable selectedRow];
    [viewsRemove setEnabled:(rowIndex >= 0)];
}

@end