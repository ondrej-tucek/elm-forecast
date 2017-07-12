// pull in desired CSS/SASS files
require( './styles/main.scss' );
// require( '../../node_modules/weather-icons/sass/weather-icons.scss' );
var $ = jQuery = require( '../../node_modules/jquery/dist/jquery.js' );           // <--- remove if jQuery not needed
require( '../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js' );   // <--- remove if Bootstrap's JS not needed

var plotlyLineGraph1 = require( './js/plotlyLineGraph1.js' );
var plotlyBarGraph1 = require( './js/plotlyBarGraph1.js' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );


app.ports.getTemperaturesData.subscribe(function(dataXY) {

    // console.log(dataXY);
    requestAnimationFrame(function() {
        plotlyLineGraph1.makeGraph(dataXY);
        plotlyBarGraph1.makeGraph(dataXY);
    });


    // var graph2 = plotlyBarGraph1.makeGraph(dataXY);
    // graph2.Main.embed( document.getElementById( 'lineGraph1' ) );

});

