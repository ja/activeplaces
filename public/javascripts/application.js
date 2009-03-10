var Map = function(mapContainerId, options) {
  this.gmap = null;
  var defaults = {
    locations : [],
    mapCenter : null,
    mapZoom : 14,
    admin: false
  }
  this.options = $.extend(defaults, options);
  
  // The actual constructor-ish setup.
  if ($(mapContainerId) && GBrowserIsCompatible()) {
    this._setup(mapContainerId, this.options);
    this.addLocations(this.options.locations);
    return this;
  }
}

// add functions to the object prototype, to save memory.
$.extend(Map.prototype, {

  _setup: function(mapContainerId, options) {
    this.gmap = new GMap2(document.getElementById(mapContainerId));
    if (options.mapCenter) {
      var center = new GLatLng(options.mapCenter[0], options.mapCenter[1]);
    } else if (options.locations.length > 0) {
      var center = new GLatLng(options.locations[0].location.latitude, options.locations[0].location.longitude);
    }
    this.gmap.setCenter(center, options.mapZoom);
    this.gmap.addControl(new GSmallMapControl());
    this.gmap.addControl(new GHierarchicalMapTypeControl());
    this.gmap.addMapType(G_PHYSICAL_MAP);
  },

  addLocations: function(locations) {
    var map = this;
    $.each(locations, function(index, data) {
      map.addLocation(data);
    });
  },
  
  addLocation: function(data) {
    var location = data.site;
    var point    = new GLatLng(location.latitude, location.longitude);
    var marker   = new GMarker(point, this.markerOptions());

    GEvent.addListener(marker, "click", function() {
      $.ajax({
        url: "/sites/" + location.id + "/summary",
        success: function(summaryHTML) {
          marker.openInfoWindowHtml(summaryHTML);
        }
      });
    });
    
    this.gmap.addOverlay(marker);
  },
  
  markerOptions: function() {
    return {draggable: this.options.admin}
  }
});


$(window).unload(GUnload);