// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ansi_up
//= require masonry
//= require images_loaded
//= require bootstrap-sprockets
// require turbolinks
//= require_tree .


$(function(){
  // Tried using multiple grid selectors, turns out it has no effect.
  // A single grid selector can be used for multiple grids.
  [
    [".grid", ".grid-item"],
    // [".navgrid, .navgrid-item"]
  ].forEach(
    function(grid_class_pair){
      var $grid = $(grid_class_pair[0]).masonry({
        // options
        itemSelector: grid_class_pair[1],
        columnWidth: 200
      });
      $grid.imagesLoaded().progress( function() {
        $grid.masonry('layout');
      });
    }
  )


})