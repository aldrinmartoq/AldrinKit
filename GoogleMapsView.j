// GoogleMapsView.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AppKit/CPView.j>


var GoogleMapsViewDidChangeBoundsNotification = @"GoogleMapsViewDidChangeBoundsNotification";

@implementation GoogleMapsView : CPView {
    id                      _delegate;
    CPString                m_mapRegion;
    
    DOMElement              m_DOMMapElement;
    Object                  m_map;
    Object                  m_geocoder;
}

- (id)initWithFrame:(CGRect)aFrame {
    self = [super initWithFrame:aFrame];

    if (self) {
        [self setBackgroundColor:[CPColor colorWithRed:229.0 / 255.0 green:227.0 / 255.0 blue:223.0 / 255.0 alpha:0.5]];

        [self _buildDOM];
    }

    return self;
}

- (void)setDelegate:(id)aDelegate {
    var defaultCenter = [CPNotificationCenter defaultCenter];
    
    if (_delegate) {
        [defaultCenter removeObserver:_delegate name:GoogleMapsViewDidChangeBoundsNotification object:self];
    }
    
    _delegate = aDelegate;
    
    if ([_delegate respondsToSelector:@selector(googleMapsViewDidChangeBounds:)]) {
        [defaultCenter
            addObserver:_delegate
               selector:@selector(googleMapsViewDidChangeBounds:)
                   name:GoogleMapsViewDidChangeBoundsNotification
                 object:self];
    }
}

- (Object)map {
    return m_map;
}

- (CPString)mapRegion {
    return m_mapRegion;
}

- (void)setMapRegion:(CPString)aMapRegion {
    m_mapRegion = aMapRegion;
}

- (Object)geoCode {
    if (!m_geocoder) {
        m_geocoder = new google.maps.Geocoder();
    }
    return m_geocoder;    
}

- (void)geoCode:(CPString)location {
    [self geoCode];
    if ([location stringByTrimmingWhitespace] == "") {
        CPLog.debug('empty');
        return;
    }
    m_geocoder.geocode( { 'address' : location + ", Chile", 'region' : 'cl', 'language' : 'es', 'bounds' : m_map.getBounds() }, function (results, status) {
       if (status == google.maps.GeocoderStatus.OK) {
           CPLog.debug('resultados: ' + JSON.stringify(results));
           m_map.setCenter(results[0].geometry.location);
           m_map.fitBounds(results[0].geometry.viewport);
       } else {
           alert("Geocode failed " + status);
       }
    });
}

- (void)_buildDOM {
    AKPerformAfterGoogleMapsScriptLoaded(function() {
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

            // google.maps.event.addListener(m_map, 'mouseout', function(mouseEvent) {
            //     CPLog.debug('out!' + mouseEvent);
            // });

            google.maps.event.addListener(m_map, 'idle', function() {
               CPLog.debug('idle changed: ' + m_map.getBounds());
            });

            style.left = "0px";
            style.top = "0px";

            _DOMElement.appendChild(m_DOMMapElement);
        });
    });
}

/*!
    Returns YES if the receiver tracks the mouse outside the frame, otherwise NO.
*/
- (BOOL)tracksMouseOutsideOfFrame {
    return YES;
}

- (void)setFrameSize:(CGSize)aSize {
    [super setFrameSize:aSize];

    if (m_DOMMapElement) {
        var bounds = [self bounds],
            style = m_DOMMapElement.style;

        style.width = CGRectGetWidth(bounds) + "px";
        style.height = CGRectGetHeight(bounds) + "px";

        google.maps.event.trigger(m_map, 'resize');
    }
}

// - (void)mouseDown:(CPEvent)anEvent {
//     var type = [anEvent type];
//     if (type === CPLeftMouseUp) {
//         CPLog.debug('CPLeftMouseUP');
//         
//         [super mouseDown:anEvent];
//     } else if (type === CPLeftMouseDown) {
//         CPLog.debug('CPLeftMouseDown');
//         //[CPApp setTarget:self selector:@selector(mouseDown:) forNextEventMatchingMask:CPLeftMouseDraggedMask untilDate:nil inMode:nil dequeue:YES];
//         
//         [super mouseDown:anEvent];
//     } else if (type === CPLeftMouseDragged) {
//         CPLog.debug('CPLeftMouseDragged');
//         //[CPApp setTarget:self selector:@selector(mouseDown:) forNextEventMatchingMask:CPLeftMouseDraggedMask | CPLeftMouseUpMask untilDate:nil inMode:nil dequeue:YES];
//         [super mouseDown:anEvent];
//     }
// }

@end



#pragma mark * Loading



var AKGoogleMapsQueue = [];
var AKPerformAfterGoogleMapsScriptLoaded = function(aFunction) {
    AKGoogleMapsQueue.push(aFunction);

    AKPerformAfterGoogleMapsScriptLoaded = function(aFunction) {
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
}

function _GoogleMapsViewCallback() {
    AKPerformAfterGoogleMapsScriptLoaded = function(aFunction) {
        aFunction();
    }

    var index = 0,
    count = AKGoogleMapsQueue.length;

    for (; index < count; index++) {
        AKGoogleMapsQueue[index]();
    }

    [[CPRunLoop currentRunLoop] limitDateForMode:CPDefaultRunLoopMode];
}



#pragma mark * Coding support



var GoogleMapsViewMapRegionKey = @"GoogleMapsViewMapRegionKey";

@implementation GoogleMapsView (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder {
    self = [super initWithCoder:aCoder];

    if (self) {
        [self setMapRegion:[aCoder decodeObjectForKey:GoogleMapsViewMapRegionKey]];

        [self _buildDOM];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:[self mapRegion] forKey:GoogleMapsViewMapRegionKey];
}

@end
