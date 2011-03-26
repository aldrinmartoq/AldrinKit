// GoogleMapsView.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AppKit/CPView.j>



@implementation GoogleMapsView : CPView
{
    CPString                m_mapRegion;
    
    DOMElement              m_DOMMapElement;
    Object                  m_map;
}

- (id)initWithFrame:(CGRect)aFrame
{
  self = [super initWithFrame:aFrame];
  
  if (self) {
    [self setBackgroundColor:[CPColor colorWithRed:229.0 / 255.0 green:227.0 / 255.0 blue:223.0 / 255.0 alpha:0.5]];
    
    [self _buildDOM];
  }
  
  console.log("initWithFrame " + aFrame + " done!");
  return self;
}

- (Object)map
{
    return m_map;
}

- (CPString)mapRegion
{
    return m_mapRegion;
}

- (void)setMapRegion:(CPString)aMapRegion {
    m_mapRegion = aMapRegion;
}

- (void)_buildDOM
{
  AKPerformAfterGoogleMapsScriptLoaded(function()
  {
          m_DOMMapElement = document.createElement("div");
          m_DOMMapElement.id = "MKMapView" + [self UID];

          var style = m_DOMMapElement.style,
              bounds = [self bounds],
              width = CGRectGetWidth(bounds),
              height = CGRectGetHeight(bounds);

          style.overflow = "hidden";
          style.position = "absolute";
          style.visibility = "visible";
          style.zIndex = 0;
          style.left = -width + "px";
          style.top = -height + "px";
          style.width = width + "px";
          style.height = height + "px";

          var myOpts = {
            zoom: 14,
            streetViewControl: false,
            center: new google.maps.LatLng(-33.44, -70.633),
            mapTypeId: google.maps.MapTypeId.ROADMAP
          }

          m_map = new google.maps.Map(m_DOMMapElement, myOpts);

          style.left = "0px";
          style.top = "0px";

          _DOMElement.appendChild(m_DOMMapElement);
      });
      console.log("map done " + m_map + " dom " + m_DOMMapElement);
  });
}

/*!
    Returns YES if the receiver tracks the mouse outside the frame, otherwise NO.
*/
- (BOOL)tracksMouseOutsideOfFrame
{
    return YES;
}

- (void)setFrameSize:(CGSize)aSize
{
    [super setFrameSize:aSize];
    
    if (m_DOMMapElement) {
        var bounds = [self bounds],
            style = m_DOMMapElement.style;
        
        style.width = CGRectGetWidth(bounds) + "px";
        style.height = CGRectGetHeight(bounds) + "px";
        
        google.maps.event.trigger(m_map, 'resize');
    }
    
    console.log("setFrameSize " + aSize + " done.");
}

- (void)mouseDown:(CPEvent)anEvent {
    var type = [anEvent type];
    if (type === CPLeftMouseUp) {
        console.log('CPLeftMouseUP');
        
        [super mouseDown:anEvent];
    } else if (type === CPLeftMouseDown) {
        console.log('CPLeftMouseDown');
        //[CPApp setTarget:self selector:@selector(mouseDown:) forNextEventMatchingMask:CPLeftMouseDraggedMask untilDate:nil inMode:nil dequeue:YES];
        
        [super mouseDown:anEvent];
    } else if (type === CPLeftMouseDragged) {
        console.log('CPLeftMouseDragged');
        //[CPApp setTarget:self selector:@selector(mouseDown:) forNextEventMatchingMask:CPLeftMouseDraggedMask | CPLeftMouseUpMask untilDate:nil inMode:nil dequeue:YES];
        [super mouseDown:anEvent];
    }
}

@end



#pragma mark * Loading



var AKGoogleMapsQueue = [];
var AKPerformAfterGoogleMapsScriptLoaded = function(aFunction)
{
  AKGoogleMapsQueue.push(aFunction);
  
  AKPerformAfterGoogleMapsScriptLoaded = function(aFunction)
  {
    AKGoogleMapsQueue.push(aFunction);    
  }
  
  if (window.google && google.maps) {
    _GoogleMapsViewCallback();
  } else {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.google.com/maps/api/js?sensor=true&callback=_GoogleMapsViewCallback";
    document.getElementsByTagName("head")[0].appendChild(script);
  }
  
  console.log("AKPerformAfterGoogleMapsScriptLoaded ... ");
}

function _GoogleMapsViewCallback()
{
  AKPerformAfterGoogleMapsScriptLoaded = function(aFunction)
  {
    aFunction();
  }
  
  var index = 0,
      count = AKGoogleMapsQueue.length;
  
  for (; index < count; index++) {
    AKGoogleMapsQueue[index]();
  }
  
  [[CPRunLoop currentRunLoop] limitDateForMode:CPDefaultRunLoopMode];
  console.log("_GoogleMapsViewCallback ... ");
}



#pragma mark * Coding support



var GoogleMapsViewMapRegionKey = @"GoogleMapsViewMapRegionKey";

@implementation GoogleMapsView (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
  self = [super initWithCoder:aCoder];
  
  if (self) {
    [self setMapRegion:[aCoder decodeObjectForKey:GoogleMapsViewMapRegionKey]];
    
    [self _buildDOM];
  }
  
  return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
  [super encodeWithCoder:aCoder];
  
  [aCoder encodeObject:[self mapRegion] forKey:GoogleMapsViewMapRegionKey];
}

@end